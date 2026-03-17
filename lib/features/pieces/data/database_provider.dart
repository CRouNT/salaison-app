import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:salaison_app/core/database/app_database.dart';

part 'database_provider.g.dart';

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
}
