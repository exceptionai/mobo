import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';
import 'package:mobo/components/circular_progress_indicator_ex.dart';
import 'package:intl/intl.dart';
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

  @override
  void initState(){
    super.initState();
    _getBot();
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

  _buildMessage(MessageHistoryModel model, bool isLast){
    bool isMe = (model.fromUser == 1);
    bool isLiked = (model.favorite == 1);
    return Column(
      children: <Widget>[
        Row(
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
                color: isMe ? Colors.white : Colors.green[50],
                borderRadius: BorderRadius.all(Radius.circular(15.0),),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(model.registerHour != null ? model.registerHour : ' ' ,
                    style:TextStyle(
                      color: Colors.blueGrey[400],
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  model.content.startsWith("http") ?
                  InkWell(
                    onTap: (){
                      launch(model.content);
                    },
                    child: Text(model.content,
                      style:TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ) :
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
        ),

        isLoading && isLast ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicatorEx(),
        ) : Container()
      ],
    );
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
       await _persistMessage(fromUser: 0, text: message);
      }
    }else{
      await _persistMessage(fromUser: 0, text: response.getMessage().isEmpty ? "Não entendi" : response.getMessage() );
    }
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
              color: Colors.white,
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
                                  return _buildMessage(messageModel, index == snapshot.data.length -1 );
                                },
                            ),
                          );
                        }else {
                          return Center (child: CircularProgressIndicatorEx());
                        }
                      }
                  ),      
                ),
              ),
              
              TextComposer(_sendMessage),
            ],
          ),
      ),
    );
  }
}