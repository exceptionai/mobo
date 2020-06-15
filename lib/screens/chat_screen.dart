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
        title:Text('Olá'),
        elevation: 0,
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
                      return ListTile(
                        title: Text(message.content),
                      );
                    },
                    reverse: false,
                  );
                } else {
                  return Center (child: CircularProgressIndicator());
                }
              }
            ), 
            
              /*StreamBuilder(
              stream: allMessages,
              builder: (context,snapshot){
                switch(snapshot.connectionState){
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    List<DocumentSnapshot> documents = snapshot.data.documents;
                  
                  return ListView.builder(
                    itemCount: documents.length,
                    reverse: true,
                    itemBuilder: (context, index){
                      return ListTile(
                        title: Text(documents[index].data['content']),
                      );
                    }
                  );
                }

              }
            ),*/
          ),
          TextComposer(_sendMessage),
        ],
      ),
    );
  }
}