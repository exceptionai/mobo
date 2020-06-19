import 'dart:async';
import 'dart:core';

import 'package:mobo/models/bot_model.dart';
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
          ${MessageHistoryModel.fromUserColumn} INTEGER,
          ${MessageHistoryModel.favoriteColumn} INTEGER,
          ${MessageHistoryModel.registerHourColumn} TEXT);""",

      """CREATE TABLE ${BotModel.tableName} (
          ${BotModel.idColumn} INTEGER PRIMARY KEY,
          ${BotModel.nameColumn} TEXT,
          ${BotModel.favoriteColumn} INTEGER,
          ${BotModel.pictureUrlColumn} INTEGER,
          ${BotModel.readyColumn} INTEGER
      );""",
    ];

    List<String> inserts = [

      /*"""INSERT INTO ${RoommateModel.tableName} (${RoommateModel.idColumn},
        ${RoommateModel.nameColumn}) VALUES (1,'Lopinho');""",
      """INSERT INTO ${RoommateModel.tableName} (${RoommateModel.idColumn},
        ${RoommateModel.nameColumn}) VALUES (2,'Renaninho');""",
      """INSERT INTO ${RoommateModel.tableName} (${RoommateModel.idColumn},
        ${RoommateModel.nameColumn}) VALUES (3,'Gustavo exemplo de ser humano');""",
      """INSERT INTO ${RoommateModel.tableName} (${RoommateModel.idColumn},
        ${RoommateModel.nameColumn}) VALUES (4,'Alissenior');""",
      """INSERT INTO ${RoommateModel.tableName} (${RoommateModel.idColumn},
        ${RoommateModel.nameColumn}) VALUES (5,'Nessa Git Engeneer');""",*/
      """INSERT INTO ${BotModel.tableName} (
          ${BotModel.idColumn},
          ${BotModel.nameColumn},
          ${BotModel.favoriteColumn},
          ${BotModel.pictureUrlColumn} ,
          ${BotModel.readyColumn}) 
          VALUES (1,'Mobo',0,'assets/images/bot(1).png',1);""",
       """INSERT INTO ${BotModel.tableName} (
          ${BotModel.idColumn},
          ${BotModel.nameColumn},
          ${BotModel.favoriteColumn},
          ${BotModel.pictureUrlColumn} ,
          ${BotModel.readyColumn}) 
          VALUES (2,'Evil Mobo(em breve)',0,'assets/images/evil-mobo.png',0);""",
       """INSERT INTO ${BotModel.tableName} (
          ${BotModel.idColumn},
          ${BotModel.nameColumn},
          ${BotModel.favoriteColumn},
          ${BotModel.pictureUrlColumn} ,
          ${BotModel.readyColumn}) 
          VALUES (3,'Telemark(em breve)',0,'assets/images/telemark.png',0);""",
        """INSERT INTO ${BotModel.tableName} (
          ${BotModel.idColumn},
          ${BotModel.nameColumn},
          ${BotModel.favoriteColumn},
          ${BotModel.pictureUrlColumn} ,
          ${BotModel.readyColumn}) 
          VALUES (4,'Junior(em breve)',0,'assets/images/junior.png',0);""",
        """INSERT INTO ${BotModel.tableName} (
          ${BotModel.idColumn},
          ${BotModel.nameColumn},
          ${BotModel.favoriteColumn},
          ${BotModel.pictureUrlColumn} ,
          ${BotModel.readyColumn}) 
          VALUES (5,'Jeremias(em breve)',0,'assets/images/jeremias.png',0);""",
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
