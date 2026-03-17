import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'app_database.g.dart';

/// Base de données principale de l'application Salaison.
/// Utilise SQLite via Drift pour le stockage local.
@DriftDatabase(tables: [Pieces, Weighings, Spices, ProductTypes, MqttSettings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Stratégie prototype: on recrée tout pour la v0.98
        await m.deleteTable('weighings');
        await m.deleteTable('spices');
        await m.deleteTable('pieces');
        await m.deleteTable('product_types');
        await m.createAll();
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');

        // Initialisation de la taxonomie par défaut
        if (details.wasCreated || details.hadUpgrade) {
          final types = [
            'Magret de canard',
            'Saucisson',
            'Saumon',
            'Filet mignon',
            'Lonzino',
            'Noix de jambon',
            'Coppa',
            'Pancetta',
          ];
          
          await batch((b) {
            b.insertAll(
              productTypes,
              types.map((t) => ProductTypesCompanion.insert(label: t)).toList(),
              mode: InsertMode.insertOrIgnore,
            );
          });
        }
      },
    );
  }
}

/// Ouvre ou crée le fichier de base de données dans le dossier documents de l'utilisateur.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
