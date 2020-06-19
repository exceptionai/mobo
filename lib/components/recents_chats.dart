import 'package:flutter/material.dart';
import 'package:mobo/components/circular_progress_indicator_ex.dart';
import 'package:mobo/models/bot_model.dart';
import 'package:mobo/models/message_history_model.dart';
import 'package:mobo/repository/bot_repository.dart';
import 'package:mobo/repository/message_history_repository.dart';

class RecentsChats extends StatefulWidget {
  @override
  _RecentsChatsState createState() => _RecentsChatsState();
}

class _RecentsChatsState extends State<RecentsChats> {
  List<BotModel> bots = [];
  bool isLoading = true;
  bool unread = true;
  List<MessageHistoryModel> messageList = [];
  @override
  void initState() {
    super.initState();
    getBots();
  }

  void getBots() async{
    var messageHistory = await MessageHistoryRepository().getAllMessageHistory();
    var botsAux = await BotRepository().getAllBots();
    //var mobo = BotModel(name: 'Mobo',pictureUrl: 'assets/images/bot(1).png', messageHistory: messageHistory); 
    setState(() {
      bots = botsAux;
      messageList = messageHistory;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(content: Text(
      'Estará disponível em breve!',
      style: TextStyle(color:Colors.white,fontWeight: FontWeight.w500,)),
      backgroundColor: Colors.blueGrey[60],
    );
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xffc1fcd3),Color(0xff0ccda3) ]),
          //color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
          child: isLoading ? CircularProgressIndicatorEx() :
          bots.length == 0 ? Container() :  ListView.builder(
            itemCount: bots.length,
            
            itemBuilder: (BuildContext context, int index) {
              final bot = bots[index];
              return InkWell(
                onTap: () async{
                  (bot.ready == 0) ? Scaffold.of(context).showSnackBar(snackBar) :
                  await Navigator.of(context).pushNamed('/chat');
                  setState(() {getBots(); });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 5.0, right: 20.0, left: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: (bot.ready != 0) ? Colors.blueGrey[50] : Colors.blueGrey[100],
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0),
                      
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          bot.pictureUrl != null ? CircleAvatar(
                            radius: 35.0,
                            backgroundColor: (bot.ready != 0) ? const Color(0xffe4e4e4) : Colors.blueGrey[100],
                            backgroundImage: AssetImage(bot.pictureUrl),
                          ) : Container(),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                bot.name,
                                style: TextStyle(
                                  color: Color(0xff42282b), 
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  messageList.length == 0 || messageList.last.content == null  ? "Nenhuma mensagem..." : messageList.last.content,
                                  style: TextStyle(
                                    color: Colors.blueGrey, 
                                    fontSize: 15.0,
                                    fontStyle: messageList.length == 0 || messageList.last.content == null  ? FontStyle.italic : FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
