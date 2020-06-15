import 'package:flutter/material.dart';

class RoommateModel{
  
  int id;
  String name;
  static final String tableName = "roommates";
  static final String idColumn = "id_roommate";
  static final String nameColumn = "name";

  RoommateModel();

  RoommateModel.withIdName(
    {@required this.id,
    @required this.name,}
  );

  RoommateModel.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
  }

  Map toMap(){
    Map<String,dynamic> map = {
      idColumn : id,
      nameColumn : name
    };
    return map;
  }

  @override
  String toString(){
    return "class (id: $id, name: $name)";
  }


}