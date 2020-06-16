import 'package:mobo/models/bot_model.dart';
import 'package:mobo/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class BotRepository{

  final DbConnection dbConnection = DbConnection();
  final String table = BotModel.tableName;
  final String idColumn = BotModel.idColumn;
  final String nameColumn = BotModel.nameColumn;
  final String favoriteColumn = BotModel.favoriteColumn;
  final String pictureUrlColumn = BotModel.pictureUrlColumn;
  final String readyColumn = BotModel.readyColumn;

  Future<List<BotModel>> getAllBots() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table");
    List<BotModel> listModel = List();
    for(Map m in listMap){
      listModel.add(BotModel.fromMap(m));
    }
    return listModel;
  }

  Future<int> updateBot(BotModel model) async {
    Database db = await dbConnection.db;
    return await db.update(table,
        model.toMap(),
        where: "$idColumn = ?",
        whereArgs: [model.id]);
  }

   Future<BotModel> getBotById(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.query(table,
      columns: [idColumn, nameColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return BotModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> getNumber() async {
    Database db = await dbConnection.db;
    return Sqflite.firstIntValue(await db.rawQuery("SELECT COUNT(*) FROM $table"));
  }

  Future close() async {
    Database db = await dbConnection.db;
    db.close();
  }


}