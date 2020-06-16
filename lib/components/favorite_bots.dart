import 'package:flutter/material.dart';
import 'package:mobo/components/circular_progress_indicator_ex.dart';
import 'package:mobo/models/bot_model.dart';

class FavoriteBots extends StatefulWidget {
  @override
  _FavoriteBotsState createState() => _FavoriteBotsState();
}

class _FavoriteBotsState extends State<FavoriteBots> {
  List<BotModel> bots = [];
  bool isLoading = true;

  @override
  void initState() { 
    super.initState();
    getBots();
  }

  void getBots() async{
    setState(() {
      bots = [ 
        // BotModel(name: 'Mobo',pictureUrl: 'assets/images/bot(1).png' )
      ];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Bots Favoritos',
                  style: TextStyle(
                    color: Color(0xff42282b), 
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.help_outline),
                  iconSize: 30.0,
                  color: Color(0xff42282b), 
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            color: const Color(0xfff2f9fb),
            child: isLoading? CircularProgressIndicatorEx() : 
            bots.length == 0 ? Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0, 
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/images/sad(2).png'),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          'Nenhum bot adicionado',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ) :
            ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: bots.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () async{
                    await Navigator.of(context).pushNamed('/chat');

                  setState(() {getBots(); });
                  },
                                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0, 
                          backgroundColor: const Color(0xffe4e4e4),
                          backgroundImage: AssetImage(bots[index].pictureUrl),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          bots[index].name,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
