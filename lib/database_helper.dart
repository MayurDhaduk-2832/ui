import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    _db ??= await initDb();
    return _db!;
  }

  Future<Database?> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'stData.db');
    final db = await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
    return db;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE Students (
            id INTEGER PRIMARY KEY,
            name TEXT,
            address TEXT,
            math TEXT,
            sci TEXT,
            eng TEXT,
            comp TEXT
          )
          ''');
  }

  Future<void> _onUpgrade(Database db, int oldV, int newV) async {
    if (newV > oldV) {
      await db.execute("ALTER TABLE Students ADD COLUMN age TEXT");
      final data = await db.query('Students');
      for (final i in data) {
        await db.update('Students', {'age': ''},
            where: 'id = ?', whereArgs: [i['id']]);
      }
    }
  }

  Future<int> insertData(Map<String, dynamic> data) async {
    final dbClient = await db;
    final res = await dbClient.insert('Students', data);
    return res;
  }

  Future<int> updateData(Map<String, dynamic> data) async {
    final dbClient = await db;
    final res = await dbClient.update(
      'Students',
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
    return res;
  }

  Future<int> deleteData(int id) async {
    final dbClient = await db;
    final res =
        await dbClient.delete('Students', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final dbClient = await db;
    final res = await dbClient.query('Students');
    return res;
  }
}
