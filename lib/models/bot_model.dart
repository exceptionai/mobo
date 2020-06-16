import 'package:flutter/material.dart';
import 'package:mobo/models/message_history_model.dart';

class BotModel{
  List<MessageHistoryModel> messageHistory = List<MessageHistoryModel>();
  String name;
  String pictureUrl;

  BotModel({this.messageHistory, @required this.name,@required this.pictureUrl});
}