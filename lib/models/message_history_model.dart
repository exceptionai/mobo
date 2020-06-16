import 'package:flutter/material.dart';

class MessageHistoryModel{
  
  int id;
  String content;
  int fromUser;
  int favorite;
  String registerHour;

  static final String tableName = "message_histories";
  static final String idColumn = "id_message_history";
  static final String contentColumn = "content";
  static final String fromUserColumn = "fromUser";
  static final String favoriteColumn = "favorite";
  static final String registerHourColumn = "registerHour";

  MessageHistoryModel();

  MessageHistoryModel.withIdName(
    {@required this.id,
    @required this.content,
    @required this.fromUser,
    @required this.registerHour}
  );

  MessageHistoryModel.fromMap(Map map){
    id = map[idColumn];
    content = map[contentColumn];
    fromUser = map[fromUserColumn];
    favorite = map[favoriteColumn];
    registerHour = map[registerHourColumn];
  }

  Map toMap(){
    Map<String,dynamic> map = {
      idColumn : id,
      contentColumn : content,
      fromUserColumn : fromUser,
      favoriteColumn : favorite,
      registerHourColumn : registerHour,
    };
    return map;
  }

  @override
  String toString(){
    return "class (id: $id, content: $content, from user ? $fromUser), favorire : $favorite, hour: $registerHour";
  }


}