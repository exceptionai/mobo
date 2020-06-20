import 'dart:async';

import 'package:fade/fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';
import 'package:mobo/components/circular_progress_indicator_ex.dart';
import 'package:intl/intl.dart';
import 'package:mobo/components/message_card_ex.dart';
import 'package:mobo/components/text_composer.dart';
import 'package:mobo/models/bot_model.dart';
import 'package:mobo/models/message_history_model.dart';
import 'package:mobo/repository/bot_repository.dart';
import 'package:mobo/repository/message_history_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {

  final String user;
  
  ChatScreen({this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  bool isLoading = true;
  bool unread = true;
  BotModel botModel = BotModel.empty();
  List<MessageHistoryModel> messageHistory = []; 

  @override
  void initState(){
    super.initState();
    _getBot();
    _getHistoryMessages();
  }
  
  void _getHistoryMessages() async{
    var messages = await MessageHistoryRepository().getAllMessageHistory();
    setState(() {
      messageHistory = messages;
    });
  }

  void _getBot() async{
    var bot = await BotRepository().getBotById(1);
    setState((){
      isLoading = false;
      botModel = bot;
    });
  }
  
  Future<MessageHistoryModel> _persistMessage({String text, int fromUser}) async{
    MessageHistoryModel model = MessageHistoryModel(content: text, fromUser: fromUser,favorite: 0);
    model.registerHour = DateFormat.Hm().format(new DateTime.now()).toString();
    model = await MessageHistoryRepository().saveMessageHistory(model);
    // var newList = [...messageHistory, model];
    setState(() {
      messageHistory.add(model);
      
    });
    setState((){});
    return model;
  }

  void _updateBot(int i) async{
    setState((){
      isLoading = true;
    });
    botModel.favorite = i;
    await BotRepository().updateBot(botModel);
    setState((){
      isLoading = false;
    });
  }



 

  void _sendMessage(String text) async{
    setState((){isLoading = true;});
    await _persistMessage(text:text, fromUser: 1);
    await _dialogFlowRequest(query: text); 
    setState((){isLoading = false;});
  }

  void _changeBotFavoriteStatus() async{
    setState((){isLoading = true;});
    int newStatus = 1;
    if(botModel.favorite == 1){
      newStatus = 0;
    }    
    _updateBot(newStatus);
    // await MessageHistoryRepository().deleteMessageHistory();
    setState((){isLoading = true;});
  }

  Future<void> _dialogFlowRequest({@required String query}) async {
    AuthGoogle authGoogle = await AuthGoogle(fileJson: "assets/credentials.json").build();
    Dialogflow dialogflow = Dialogflow(authGoogle: authGoogle, language: "pt-BR");
    AIResponse response = await dialogflow.detectIntent(query);
   
    List<Map<String, dynamic>> messages = response.getListMessage().cast<Map<String, dynamic>>();
    if( messages != null && messages.isNotEmpty){
      List<String> messageList = messages.first["text"]["text"].cast<String>();
      for(var message in messageList){
       await _persistMessage(fromUser: 0, text: message == null || message.isEmpty ? "Não entendi" : message);
      }
    }else{
      await _persistMessage(fromUser: 0, text: response.getMessage().isEmpty ? "Não entendi" : response.getMessage() );
    }
  }

  @override
  Widget build(BuildContext context) {
  
   return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
          iconSize: 30.0,
          onPressed:(){
            Navigator.of(context).pushNamed('/');
          }, 
        ),
        actions: <Widget>[
          (botModel.favorite == 1) ?
            IconButton(
              icon : Icon(Icons.star),
              iconSize: 30.0,
              color: Theme.of(context).primaryColor,
              onPressed:(){
                _changeBotFavoriteStatus();
              },) : 
            IconButton(
              icon : Icon(Icons.star_border),
              color: Theme.of(context).primaryColor,
              iconSize: 30.0,
              onPressed:(){
                _changeBotFavoriteStatus();
              } 
            ),
          ],
        centerTitle: true,
        title:Text(
          botModel?.name ?? "",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey[400],
          ),
        ),
        
        elevation: 0.0,
      ),
      body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xffc1fcd3),Color(0xff0ccda3) ]
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child:ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.only(top: 15.0),
                                itemCount: _getMessagesAmount(),
                                itemBuilder: (BuildContext context, int index){
                                  MessageHistoryModel messageModel = messageHistory[index];
                                  return MessageCardEx(model:messageModel,isLast: index == messageHistory.length -1, isLoading: isLoading, );
                                },
                            ),
                          ) 
                  )
              ),
              
              TextComposer(_sendMessage),
            ],
          ),
      ),
    );

  }
    int _getMessagesAmount(){
      return messageHistory.length;
    }
}