import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/v2/auth_google.dart';
import 'package:flutter_dialogflow/v2/dialogflow_v2.dart';
import 'package:mobo/components/circular_progress_indicator_ex.dart';
import 'package:mobo/components/text_composer.dart';
import 'package:mobo/models/message_history_model.dart';
import 'package:mobo/repository/message_history_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  bool isLoading = true;

  Future<MessageHistoryModel> _persistMessage({String text, int fromUser}) async{

    MessageHistoryModel model = MessageHistoryModel(content: text, fromUser: 1);
    model = await MessageHistoryRepository().saveMessageHistory(model);
    return model;
  }

  void _sendMessage(String text) async{
    setState((){isLoading = true;});
    await _persistMessage(text:text, fromUser: 1);
    await _dialogFlowRequest(query: text); 
    setState((){isLoading = false;});
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
      await _persistMessage(fromUser: 0, text: response.getMessage());
    }
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
        title:Text('Mobo'),
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
                        title: message.content.startsWith("http") ? InkWell(
                          child: Text(message.content,style: TextStyle(color: Colors.lightBlue),),
                          onTap: (){
                            launch(message.content);
                          },
                        ) : Text(message.content == null ? "Não entendi" : message.content),
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