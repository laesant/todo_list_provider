
import 'package:sqflite/sqflite.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE todo (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      descricao VARCHAR(500) NOT NULL,
      data_hora DATETIME,
      finalizado INTEGER
      );
''');
  }

  @override
  void upgrade(Batch batch) {}
}
