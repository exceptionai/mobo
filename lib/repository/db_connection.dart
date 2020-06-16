import 'dart:async';
import 'dart:core';

import 'package:mobo/models/message_history_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mobo/models/roommate_model.dart';

class DbConnection {

  DbConnection();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }
  
  static Future _onConfigure (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "mobo.db");

    List<String> createQueryes = [
      """CREATE TABLE ${RoommateModel.tableName}(
          ${RoommateModel.idColumn} INTEGER PRIMARY KEY,
          ${RoommateModel.nameColumn} TEXT);""",
        
      """CREATE TABLE ${MessageHistoryModel.tableName}(
          ${MessageHistoryModel.idColumn} INTEGER PRIMARY KEY,
          ${MessageHistoryModel.contentColumn} TEXT,
          ${MessageHistoryModel.fromUserColumn} INTEGER);""",
    ];

    List<String> inserts = [

      """INSERT INTO ${RoommateModel.tableName} (${RoommateModel.idColumn},
        ${RoommateModel.nameColumn}) VALUES (1,'Lopinho');"""
    ];
    
    return await openDatabase(path, version: 1, onConfigure: _onConfigure, onCreate: (Database db, int newerVersion) async {
      
      for (String create in createQueryes){
        await db.execute(create);
      }
      for (String insert in inserts){
        await db.execute(insert);
      }
      
    });
  }
}
