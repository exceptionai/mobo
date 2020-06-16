import 'package:mobo/models/message_history_model.dart';
import 'package:mobo/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class MessageHistoryRepository{

  final DbConnection dbConnection = DbConnection();
  final String table = MessageHistoryModel.tableName;
  final String idColumn = MessageHistoryModel.idColumn;
  final String contentColumn = MessageHistoryModel.contentColumn;
  final String fromUserColumn = MessageHistoryModel.fromUserColumn;
  final String favoriteColumn = MessageHistoryModel.favoriteColumn;
  final String registerHourColumn = MessageHistoryModel.registerHourColumn;

  Future<List<MessageHistoryModel>> getAllMessageHistory() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table");
    List<MessageHistoryModel> listModel = List();
    for (Map m in listMap){
      listModel.add(MessageHistoryModel.fromMap(m));
    };
    return listModel;
  }

  Future<MessageHistoryModel> saveMessageHistory(MessageHistoryModel model) async{
    Database db = await dbConnection.db;
    model.id = await db.insert(table, model.toMap());
    return model;
  }

  Future<MessageHistoryModel> getMessageHistory(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.query(
      table,
      columns: [idColumn,contentColumn,fromUserColumn,favoriteColumn,registerHourColumn],
      whereArgs: [id]);
      if(maps.length > 0){
        return MessageHistoryModel.fromMap(maps.first);
      }else{
        return null;
      }
  }

  Future<int> deleteMessageHistory(int id) async {
    Database db = await dbConnection.db;
    return await db.delete(table, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateMessageHistory(MessageHistoryModel model) async {
    Database db = await dbConnection.db;
    return await db.update(table,
        model.toMap(),
        where: "$idColumn = ?",
        whereArgs: [model.id]);
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