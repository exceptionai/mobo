import 'package:flutter/material.dart';

class MessageHistoryModel{
  
  int id;
  String content;
  int fromUser;

  static final String tableName = "message_histories";
  static final String idColumn = "id_message_history";
  static final String contentColumn = "content";
  static final String fromUserColumn = "fromUser";

  MessageHistoryModel();

  MessageHistoryModel.withIdName(
    {@required this.id,
    @required this.content,
    @required this.fromUser}
  );

  MessageHistoryModel.fromMap(Map map){
    id = map[idColumn];
    content = map[contentColumn];
  }

  Map toMap(){
    Map<String,dynamic> map = {
      idColumn : id,
      contentColumn : content,
      fromUserColumn : fromUser,
    };
    return map;
  }

  @override
  String toString(){
    return "class (id: $id, content: $content, from user ? $fromUser)";
  }


}