import 'package:flutter/material.dart';

class RecentsChats extends StatefulWidget {
  @override
  _RecentsChatsState createState() => _RecentsChatsState();
}

class _RecentsChatsState extends State<RecentsChats> {
  final List<String> chats = ['Alisson', 'Gabriel', 'Vanessa', 'Gustavo', 'Felipe', 'João'];
  String images = 'assets/images/avatar.jpg';
  bool unread = true;
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
          child: ListView.builder(
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              final chat = chats[index];
              return InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('/chat');
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
                            backgroundImage: AssetImage(images),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                chat,
                                style: TextStyle(
                                  color: Colors.grey, 
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  'Olá, tudo bem com você?',
                                  style: TextStyle(
                                    color: Colors.blueGrey, 
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            '03:15', // Quero dormir .zZ .zZ
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0,),
                          unread ? Container(
                            width: 40.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Novo',
                              style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                          )
                          : Text(''),
                        ],
                      )
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
