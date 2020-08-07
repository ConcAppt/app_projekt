import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'package:appprojekt/models/user.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:appprojekt/models/data.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  factory DBProvider() => db;
  static Database _database;

  Future<Database> get database async {
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'app_projekt.db'),
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            name TEXT, age INTEGER, email TEXT PRIMARY KEY, password TEXT
          )
        ''');
      },
      version: 2
    );
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

  Future<User> loginUser(String email, String password) async{
    var db = await database;
    var result = await db.rawQuery('''
    SELECT * FROM users WHERE email = ? AND password = ?''',
        [email, password]);
    if (result.length == 0) return null;
    
    return User.fromJson(result.first);

  }

  Future<int> deleteUsers() async {
    var db = await database;
    int res = await db.delete("users");
    return res;
  }

  initDaB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'app_projekt.db'),
        onCreate: (db, version) async {
          await db.execute('''
          CREATE TABLE data (
            email TEXT PRIMARY KEY, date INTEGER, value INTEGER
          )
        ''');
        },
        version: 2
    );
  }

  newValueQ(Data newValueQ) async {
    final db = await database;

    var res = await db.rawInsert('''
      INSERT INTO data(
        email, date, value
      ) VALUES (?, ?, ?)
    ''', [newValueQ.email, newValueQ.date, newValueQ.value]);

    return res;
  }

  Future<Data> getData(String email) async{
    var db = await database;
    var result = await db.rawQuery('''
    SELECT * FROM users WHERE email = ?''',
        [email]);
    if (result.length == 0) return null;

    return Data.fromJson(result.first);//get latest data --> add week, month or year

  }

}