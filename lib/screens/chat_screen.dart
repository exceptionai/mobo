import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobo/components/text_composer.dart';
import 'package:mobo/models/message_history_model.dart';
import 'package:mobo/repository/db_connection.dart';
import 'package:mobo/repository/message_history_repository.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  void _sendMessage(String text) async{
    MessageHistoryModel model = MessageHistoryModel();
    model.content = text;
    model.fromUser = 1;
    model = await MessageHistoryRepository().saveMessageHistory(model);
    setState(() {
      
    });
    print(model.toString());
  }
  
  @override
  Widget build(BuildContext context) {
  
   //StreamController<MessageHistoryModel> _messageListController = StreamController<MessageHistoryModel>();
   //Stream<MessageHistoryModel> allMessages = _messageListController.stream;
   
   /*void _listAll() async {
     for(MessageHistoryModel model in await MessageHistoryRepository().getAllMessageHistory()){
       _messageListController.sink.add(model);
     }
   }*/

   //_listAll();

   return Scaffold(
      appBar: AppBar(
        title:Text(
          'Chat com a Mobo ',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder<List<MessageHistoryModel>>(
              future: MessageHistoryRepository().getAllMessageHistory(),
              builder: (BuildContext context, AsyncSnapshot<List<MessageHistoryModel>> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index){
                      MessageHistoryModel message = snapshot.data[index];
                      Color colorBackground = Colors.green[900];
                      Color colorText = Colors.white;
                      TextAlign textAlign = TextAlign.end;
                      print(message.fromUser);
                      if(message.fromUser == 1){
                        colorBackground = Color(0xFFFFEFEE);
                        colorText = Colors.black;
                        textAlign = TextAlign.start;
                      }
                      return Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: colorBackground,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)
                          ),
                        ),
                        child: Text(message.content,
                          style: TextStyle(
                                color: colorText, 
                                fontSize: 19.0,
                                fontWeight: FontWeight.w600,
                          ),
                          textAlign: textAlign,
                        ),
                      );
                    },
                    reverse: false,
                  );
                } else {
                  return Center (child: CircularProgressIndicator());
                }
              }
            ), 
          ),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}