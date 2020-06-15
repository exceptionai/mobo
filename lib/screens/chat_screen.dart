import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobo/components/text_composer.dart';
import 'package:mobo/models/message_history_model.dart';
import 'package:mobo/repository/db_connection.dart';
import 'package:mobo/repository/message_history_repository.dart';

class ChatScreen extends StatefulWidget {

  final String user;

  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  _buildMessage(MessageHistoryModel model){
    bool isMe = (model.fromUser == 1);
    bool isLiked = (model.favorite == 1);
    return Row(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.65,
          margin: isMe ? EdgeInsets.only(
            top: 8.0, 
            bottom: 8.0,
            left: 80.0,
            right: 20.0
          ) : EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 20.0
          ),
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).accentColor : Colors.green[50],
            borderRadius: BorderRadius.all(Radius.circular(15.0),),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(model.registerHour,
                style:TextStyle(
                  color: Colors.blueGrey[400],
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(model.content,
                style:TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        isMe ? SizedBox.shrink() : IconButton(
          icon: isLiked ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: isLiked ? Colors.redAccent[100] : Colors.blueGrey,
          onPressed: (){
            _changeFavoriteStatus(model);
          },
        ),
      ],
    );
  }

  void _sendMessage(String text) async{
    MessageHistoryModel model = MessageHistoryModel();
    model.content = text;
    model.fromUser = 1;
    model.favorite = 0;
    model.registerHour = DateFormat.Hm().format(new DateTime.now()).toString();
    model = await MessageHistoryRepository().saveMessageHistory(model);
    setState(() {
      
    });
    print(model.toString());
  }

  void _changeFavoriteStatus(MessageHistoryModel model) async{
    if(model.favorite == 1){
      model.favorite = 0;
    }else{
      model.favorite = 1;
    }
    await MessageHistoryRepository().updateMessageHistory(model);
    setState(() {
      
    });
  }  
  @override
  Widget build(BuildContext context) {
  
   return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title:Center(
          child: Text(
            widget.user,
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            onPressed: (){},
          ),
        ],
        elevation: 0.0,
      ),
      body:GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child:FutureBuilder<List<MessageHistoryModel>>(
                    future: MessageHistoryRepository().getAllMessageHistory(),
                      builder: (BuildContext context, AsyncSnapshot<List<MessageHistoryModel>> snapshot){
                        if(snapshot.hasData){
                          return ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 15.0),
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index){
                                  MessageHistoryModel messageModel = snapshot.data[index];
                                  return _buildMessage(messageModel);
                                },
                            ),
                          );
                        }else {
                          return Center (child: CircularProgressIndicator());
                        }
                      }
                  ),      
                ),
              ),
              
              TextComposer(_sendMessage),
            ],
          ),
      ),
       
      /*Column(
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
      ),*/
    );
  }
}