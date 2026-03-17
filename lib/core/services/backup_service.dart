import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/pieces_repository.dart';
import 'package:salaison_app/features/pieces/data/taxonomy_repository.dart';

class BackupService {
  final PiecesRepository piecesRepo;
  final TaxonomyRepository taxonomyRepo;

  BackupService(this.piecesRepo, this.taxonomyRepo);

  Future<String?> exportData() async {
    try {
      final pieces = await piecesRepo.watchAllPieces().first;
      final taxonomy = await taxonomyRepo.watchAllProductTypes().first;

      final data = {
        'exportDate': DateTime.now().toIso8601String(),
        'appVersion': 'v1.0.2-Pre-Flight',
        'pieces': pieces.map((p) => p.toJson()).toList(),
        'taxonomy': taxonomy.map((t) => t.toJson()).toList(),
      };

      final jsonString = jsonEncode(data);
      
      // Enregistrement temporaire pour le partage/téléchargement
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/salaison_backup_${DateTime.now().millisecondsSinceEpoch}.json');
      await file.writeAsString(jsonString);

      return file.path;
    } catch (e) {
      return null;
    }
  }
}
