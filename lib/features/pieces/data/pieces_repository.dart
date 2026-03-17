import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/database_provider.dart';
import 'package:salaison_app/core/services/mqtt_service.dart';

part 'pieces_repository.g.dart';

@riverpod
PiecesRepository piecesRepository(PiecesRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return PiecesRepository(db, ref);
}

/// Repository gérant les opérations sur les pièces de salaison, les pesées et les épices.
/// Centralise les accès à la base de données Drift via des flux (Streams) et futurs.
class PiecesRepository {
  final AppDatabase _db;
  final PiecesRepositoryRef _ref;
  PiecesRepository(this._db, this._ref);

  /// Surveille toutes les pièces enregistrées en base.
  /// Retourne un flux qui se met à jour automatiquement lors de modifications.
  Stream<List<Piece>> watchAllPieces() {
    return _db.select(_db.pieces).watch();
  }

  /// Surveille une pièce spécifique par son ID.
  /// Utile pour l'affichage des détails en temps réel.
  Stream<Piece> watchPiece(int id) {
    return (_db.select(_db.pieces)..where((t) => t.id.equals(id))).watchSingle();
  }

  /// Surveille l'historique des pesées pour une pièce donnée.
  /// Trié par date décroissante pour afficher les plus récentes en haut.
  Stream<List<Weighing>> watchWeighingsForPiece(int pieceId) {
    return (_db.select(_db.weighings)
          ..where((t) => t.pieceId.equals(pieceId))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .watch();
  }

  /// Surveille les épices secondaires associées à une pièce.
  Stream<List<Spice>> watchSpicesForPiece(int pieceId) {
    return (_db.select(_db.spices)..where((t) => t.pieceId.equals(pieceId))).watch();
  }

  /// Ajoute une nouvelle pièce de salaison.
  /// @return L'ID de la pièce créée.
  Future<int> addPiece(PiecesCompanion piece) async {
    try {
      return await _db.into(_db.pieces).insert(piece);
    } catch (e) {
      throw Exception('Erreur lors du calcul ou de la création de la pièce: $e');
    }
  }

  /// Met à jour l'intégralité d'une pièce existante.
  Future<bool> updatePiece(PiecesCompanion piece) async {
    try {
      return await _db.update(_db.pieces).replace(piece);
    } catch (e) {
      return false;
    }
  }

  /// Enregistre une pesée ponctuelle pour une pièce.
  Future<int> addWeighing(WeighingsCompanion weighing) async {
    try {
      final id = await _db.into(_db.weighings).insert(weighing);
      _triggerMqtt(weighing.pieceId.value, id);
      return id;
    } catch (e) {
      throw Exception('Erreur lors de l\'enregistrement de la pesée: $e');
    }
  }

  /// Enregistre une liste de pesées en une seule transaction.
  Future<void> addWeighings(List<WeighingsCompanion> companions) async {
    await _db.batch((batch) {
      batch.insertAll(_db.weighings, companions);
    });
    // Trigger MQTT for each (could be optimized but okay for now)
    for (var comp in companions) {
      // Find the last weighing ID for this piece (drift doesn't return IDs in batch insertAll easily)
      final last = await (_db.select(_db.weighings)
            ..where((t) => t.pieceId.equals(comp.pieceId.value))
            ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
            ..limit(1))
          .getSingleOrNull();
      if (last != null) {
        _triggerMqtt(comp.pieceId.value, last.id);
      }
    }
  }

  Future<void> _triggerMqtt(int pieceId, int weighingId) async {
    try {
      final piece = await (_db.select(_db.pieces)..where((t) => t.id.equals(pieceId))).getSingle();
      final weighing = await (_db.select(_db.weighings)..where((t) => t.id.equals(weighingId))).getSingle();
      
      final baseWeight = piece.preDryingWeight ?? piece.poidsInitial;
      final lossPct = 1 - (weighing.poids / baseWeight);
      
      _ref.read(mqttServiceProvider.notifier).publishWeighing(piece, weighing, lossPct);
    } catch (e) {
      // Silently fail for MQTT to not block the main flow
    }
  }
  
  /// Ajoute une ligne d'épice individuelle.
  Future<int> addSpice(SpicesCompanion spice) {
    return _db.into(_db.spices).insert(spice);
  }

  /// Met à jour la liste des épices d'une pièce.
  /// Utilise un batch de suppression/recréation pour garantir l'intégrité atomique.
  Future<void> updateSpices(int pieceId, List<SpicesCompanion> spices) async {
    await _db.transaction(() async {
      await (_db.delete(_db.spices)..where((t) => t.pieceId.equals(pieceId))).go();
      await _db.batch((batch) {
        batch.insertAll(_db.spices, spices);
      });
    });
  }

  /// Supprime une pièce et CASCADE manuellement sur les pesées et épices.
  /// Regroupé dans une transaction pour éviter les données orphelines.
  Future<void> deletePiece(int pieceId) async {
    try {
      await _db.transaction(() async {
        await (_db.delete(_db.weighings)..where((t) => t.pieceId.equals(pieceId))).go();
        await (_db.delete(_db.spices)..where((t) => t.pieceId.equals(pieceId))).go();
        await (_db.delete(_db.pieces)..where((t) => t.id.equals(pieceId))).go();
      });
    } catch (e) {
      throw Exception('Échec de la suppression sécurisée: $e');
    }
  }
}
