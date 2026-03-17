import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salaison_app/core/database/app_database.dart';
import 'package:salaison_app/features/pieces/data/database_provider.dart';

part 'taxonomy_repository.g.dart';

@riverpod
TaxonomyRepository taxonomyRepository(TaxonomyRepositoryRef ref) {
  final db = ref.watch(appDatabaseProvider);
  return TaxonomyRepository(db);
}

/// Repository gérant la taxonomie des produits (ProductTypes).
class TaxonomyRepository {
  final AppDatabase _db;
  TaxonomyRepository(this._db);

  /// Surveille tous les types de produits disponibles.
  Stream<List<ProductType>> watchAllProductTypes() {
    return (_db.select(_db.productTypes)
          ..orderBy([(t) => OrderingTerm(expression: t.label, mode: OrderingMode.asc)]))
        .watch();
  }

  /// Récupère la liste statique des types de produits.
  Future<List<ProductType>> getAllProductTypes() {
    return (_db.select(_db.productTypes)
          ..orderBy([(t) => OrderingTerm(expression: t.label, mode: OrderingMode.asc)]))
        .get();
  }

  /// Ajoute un nouveau type de produit (Magret, Coppa, etc.).
  Future<int> addProductType(ProductTypesCompanion type) {
    return _db.into(_db.productTypes).insert(type);
  }

  /// Met à jour un type de produit existant.
  Future<bool> updateProductType(ProductTypesCompanion type) {
    return _db.update(_db.productTypes).replace(type);
  }

  /// Vérifie si un type est actuellement utilisé par au moins une pièce.
  Future<bool> isTypeUsed(int typeId) async {
    final query = _db.select(_db.pieces)..where((p) => p.productTypeId.equals(typeId));
    final result = await query.get();
    return result.isNotEmpty;
  }

  /// Supprime un type de produit s'il n'est pas utilisé.
  Future<void> deleteProductType(int id) async {
    if (await isTypeUsed(id)) {
      throw Exception('Ce type est utilisé par une pièce et ne peut être supprimé.');
    }
    await (_db.delete(_db.productTypes)..where((t) => t.id.equals(id))).go();
  }
}
