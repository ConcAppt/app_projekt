import 'dart:convert';

import 'package:appprojekt/models/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:appprojekt/models/user.dart';
import 'dart:async';
import 'dart:io' as io;

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  factory DBProvider() => db;
  static Database _database;

  //static Database _databaseQ;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  /*Future<Database> get databaseQ async {
    if(_databaseQ != null)
      return _databaseQ;

    _databaseQ = await initDBQ();
    return _databaseQ;
  }*/

  initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'app_projekt.db'),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE users (
            name TEXT, age INTEGER, email TEXT PRIMARY KEY, password TEXT
          )
        ''');
      await db.execute('''
          CREATE TABLE ques (
            id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, date TEXT, 
            questionnaire TEXT, answers VARCHAR
          )
          ''');
    }, version: 3);
  }

  newUser(User newUser) async {
    final db = await database;

    var res = await db.rawInsert('''
      INSERT INTO users(
        name, age, email, password
      ) VALUES (?, ?, ?, ?)
    ''', [newUser.name, newUser.age, newUser.email, newUser.password]);

    return res;
  }

  Future<User> loginUser(String email, String password) async {
    var db = await database;
    var result = await db.rawQuery('''
    SELECT * FROM users WHERE email = ? AND password = ?''', [email, password]);
    if (result.length == 0) return null;

    return User.fromJson(result.first);
  }

  Future<int> changeName(String name, String email, String password) async {
    var db = await database;
    var changeName = await db.rawUpdate('''
    UPDATE users SET name = ? WHERE email = ? AND password = ? 
    ''', [name, email, password]);

    return changeName;
  }

  Future<int> changeAge(int age, String email, String password) async {
    var db = await database;
    var changeAge = await db.rawUpdate('''
    UPDATE users SET age = ? WHERE email = ? AND password = ? 
    ''', [age, email, password]);

    return changeAge;
  }

  Future<int> changeMail(String mail, String email, String password) async {
    var db = await database;
    var changeMail = await db.rawUpdate('''
    UPDATE users SET email = ? WHERE email = ? AND password = ? 
    ''', [mail, email, password]);

    return changeMail;
  }

  Future<int> changePassword(String pass, String email, String password) async {
    var db = await database;
    var changePassword = await db.rawUpdate('''
    UPDATE users SET password = ? WHERE email = ? AND password = ? 
    ''', [pass, email, password]);

    return changePassword;
  }

  Future<int> deleteUsers() async {
    var db = await database;
    int res = await db.delete("users");
    return res;
  }

  newQuestionnaire(Data data) async {
    final db = await database;

    var res = await db.rawInsert('''
      INSERT INTO ques(
        email, date, questionnaire, answers
      ) VALUES (?, ?, ?, ?)
    ''', [data.email, data.date, data.questionnaire, data.answers]);

    return res;
  }

  Future<Map<dynamic, dynamic>> getValues(
      String email, String questionnaire, int i) async {
    var db = await database;
    var result = await db.rawQuery('''
    SELECT * FROM ques WHERE email = ? AND questionnaire = ?''',
        [email, questionnaire]);
    if (result.length == 0) return null;

    if (questionnaire == "ERQ") {
      Map<dynamic, dynamic> map = result[i];
      String str = map["answers"];
      Map<dynamic, dynamic> newmap = jsonDecode(str);

      return newmap;
    }

    if (questionnaire == "FSFI") {
      Map<dynamic, dynamic> map = result[i];
      String str = map["answers"];
      Map<dynamic, dynamic> newmap = jsonDecode(str);

      return newmap;
    }

    if ((questionnaire == "EMQUE") || (questionnaire == "emQue")) {
      Map<dynamic, dynamic> map = result[i];
      String str = map["answers"];
      Map<dynamic, dynamic> newmap = jsonDecode(str);

      return newmap;
    }
  }

  Future<String> getRecords(String email, String questionnaire) async {
    var db = await database;
    var resultRecords = await db.rawQuery('''
    SELECT count(id) FROM ques WHERE email = ? AND questionnaire = ?
    ''', [email, questionnaire]);
    if (resultRecords.length == 0) return "No Records available";

    return jsonEncode(resultRecords);
  }
}
