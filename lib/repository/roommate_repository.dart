import 'package:mobo/models/roommate_model.dart';
import 'package:mobo/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';



class RoommateRepository{

  final DbConnection dbConnection = DbConnection();
  final String table = RoommateModel.tableName;
  final String idColumn = RoommateModel.idColumn;
  final String nameColumn = RoommateModel.nameColumn;

  Future<List> getAllRoommatees() async {
    Database db = await dbConnection.db;
    List listMap = await db.rawQuery("SELECT * FROM $table;");
    List<RoommateModel> listModel = List();
    for(Map m in listMap){
      listModel.add(RoommateModel.fromMap(m));
    }
    return listModel;
  }

  Future<RoommateModel> saveRoommate(RoommateModel model) async {
    Database db = await dbConnection.db;
    model.id = await db.insert(table, model.toMap());
    return model;
  }

  Future<RoommateModel> getRoommate(int id) async {
    Database db = await dbConnection.db;
    List<Map> maps = await db.query(table,
      columns: [idColumn, nameColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return RoommateModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteRoommate(int id) async {
    Database db = await dbConnection.db;
    return await db.delete(table, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateRoommate(RoommateModel model) async {
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