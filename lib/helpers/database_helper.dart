import 'dart:io';

import 'package:japanese_dictionary/models/translation_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String translationTable = 'translation_table';
  String colId = 'id';
  String colWord = 'word';
  String colReading = 'reading';
  String colEnglish = 'english';
  String colIsCommon = 'isCommon';
  String colJLPTLevel = 'jlptLevel';

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + '/saved_translations.db';
    final translationDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return translationDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $translationTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colWord TEXT, $colReading TEXT, $colEnglish TEXT, $colIsCommon TEXT,$colJLPTLevel TEXT)',
    );
  }

  Future<List<Map<String, dynamic>>> getTranslationMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(translationTable);
    return result;
  }

  Future<List<Translation>> getTranslationList() async {
    final List<Map<String, dynamic>> translationMapList =
        await getTranslationMapList();
    final List<Translation> translationList = [];
    translationMapList.forEach((translationMap) {
      translationList.add(Translation.fromMap(translationMap));
    });
    return translationList;
  }

  Future<int> insertTranslation(Translation translation) async {
    Database db = await this.db;
    final int result = await db.insert(translationTable, translation.toMap());
    return result;
  }

  Future<int> deleteTranslation(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      translationTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
