import 'package:flutter/material.dart';
import 'package:mobo/components/circular_progress_indicator_ex.dart';
import 'package:mobo/models/bot_model.dart';
import 'package:mobo/repository/message_history_repository.dart';

class RecentsChats extends StatefulWidget {
  @override
  _RecentsChatsState createState() => _RecentsChatsState();
}

class _RecentsChatsState extends State<RecentsChats> {
  List<BotModel> bots = [];
  bool isLoading = true;
  bool unread = true;

  @override
  void initState() {
    super.initState();
    getBots();
  }

  void getBots() async{
    var messageHistory = await MessageHistoryRepository().getAllMessageHistory();
    var mobo = BotModel(name: 'Mobo',pictureUrl: 'assets/images/bot(1).png', messageHistory: messageHistory); 
    setState(() {
      bots = [mobo];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
                  await Navigator.of(context).pushNamed('/chat');
                  setState(() {getBots(); });
                },
                              child: Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFEFEE),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundColor: const Color(0xffe4e4e4),
                            backgroundImage: AssetImage(bot.pictureUrl),
                          ),
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
                                  bot.messageHistory.length == 0 || bot.messageHistory.last.content == null  ? "Nenhuma mensagem..." : bot.messageHistory.last.content,
                                  style: TextStyle(
                                    color: Colors.blueGrey, 
                                    fontSize: 15.0,
                                    fontStyle: bot.messageHistory.length == 0 || bot.messageHistory.last.content == null  ? FontStyle.italic : FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Column(
                      //   children: <Widget>[
                      //     Text(
                      //       '03:15', // Quero dormir .zZ .zZ
                      //       style: TextStyle(
                      //         color: Colors.grey,
                      //         fontSize: 15.0,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                          
                      //   ],
                      // )
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
