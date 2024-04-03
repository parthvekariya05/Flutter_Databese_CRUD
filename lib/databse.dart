import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static const String TB_NAME = "Student";

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    Database database = await openDatabase(
      "${databasePath}/my_database.db",
      version: 1,
      onUpgrade: (db, oldVersion, newVersion) {},
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE Student(studentID INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,email TEXT");
      },
    );
    return database;
  }

  Future<List<Map<String, Object?>>> getAllUser() async {
    Database db = await initDatabase();
    List<Map<String, dynamic>> list =
    await db.rawQuery("SELECT * FROM Student");
    return list;
  }

  Future<int> deleteData(int id) async {
    Database db = await initDatabase();
    var data = db.delete("$TB_NAME", where: "studentID=?", whereArgs: [id]);
    return data;
  }

  Future<int> insertData({name, email}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = {};
    map['name'] = name;
    map['email'] = email;
    var data = db.insert(TB_NAME, map);
    return data;
  }

  Future<int> updateData({name, email, id}) async {
    Database db = await initDatabase();
    Map<String, Object?> map = {};
    map['name'] = name;
    map['email'] = email;
    var data =
        db.update("$TB_NAME", map, where: "studentID=?", whereArgs: [id]);
    return data;
  }
}