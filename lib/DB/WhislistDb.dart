import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:watchm_app/Api/whislist.dart';
import 'package:watchm_app/Whislist.dart';

class WhislistDb {
  static final WhislistDb instance = WhislistDb.init();

  static Database? _database;

  WhislistDb.init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('whislist.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''CREATE TABLE $tabelnamewhislist (
    ${WhislistFields().id} $idType,
    ${WhislistFields.name} $textType,
    ${WhislistFields.poster} $textType,
    ${WhislistFields.popularity} $textType
    
    
    )''');
  }

  Future<WhislistModel> create(WhislistModel news) async {
    final db = await instance.database;

    final id = await db.insert(tabelnamewhislist, news.toJson());
    return news.copy(id: id);
  }

  Future<WhislistModel> read(int? id) async {
    final db = await instance.database;

    final maps = await db.query(
      tabelnamewhislist,
      columns: WhislistFields().values,
      where: '${WhislistFields().id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return WhislistModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<WhislistModel>> readAll() async {
    final db = await instance.database;

    final result = await db.query(tabelnamewhislist);

    return result.map((json) => WhislistModel.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
