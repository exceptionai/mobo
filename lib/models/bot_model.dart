import 'package:flutter/material.dart';
import 'package:mobo/models/message_history_model.dart';

class BotModel{
  //List<MessageHistoryModel> messageHistory = List<MessageHistoryModel>();
  String name;
  String pictureUrl;
  int id;
  int favorite;
  int ready;

  static final String tableName = "bots";
  static final String idColumn = "id_bots";
  static final String nameColumn = "name";
  static final String favoriteColumn = "favorite";
  static final String pictureUrlColumn = "picture_url";
  static final String readyColumn = "ready";

  BotModel({@required this.name,@required this.pictureUrl});
  BotModel.empty();
  
  BotModel.withIdName(
    {
      @required this.id,
      @required this.name,
      @required this.favorite,
      @required this.pictureUrl,
      @required this.ready,
    }
  );

  BotModel.fromMap(Map map){
    id = map[idColumn];
    name = map[nameColumn];
    favorite = map[favoriteColumn];
    pictureUrl = map[pictureUrlColumn];
    ready = map[readyColumn];
  }

  Map toMap(){
    Map<String,dynamic> map = {
      idColumn : id,
      nameColumn : name,
      favoriteColumn : favorite,
      pictureUrlColumn : pictureUrl,
      readyColumn : ready,
    };
    return map;
  }

  @override
  String toString(){
    return "class (id: $id, name: $name, favorite: $favorite, img:$pictureUrl, ready:$ready)";
  }


}