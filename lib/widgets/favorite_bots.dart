import 'package:flutter/material.dart';
import 'package:mobo/screens/chat_screen.dart';

class FavoriteBots extends StatefulWidget {
  @override
  _FavoriteBotsState createState() => _FavoriteBotsState();
}

class _FavoriteBotsState extends State<FavoriteBots> {
  final List<String> favorites = [
    'Alisson',
    'Renan',
    'Lopes',
    'Gustavo',
    'Vanessa'
  ];

  String images = 'assets/images/avatar.jpg';
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
                  'Bots Favortitos',
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_horiz),
                  iconSize: 30.0,
                  color: Colors.blueGrey,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 120.0,
            color: Theme.of(context).accentColor,
            child: ListView.builder(
              padding: EdgeInsets.only(left: 10.0),
              scrollDirection: Axis.horizontal,
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.all(10.0),
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:(context) => ChatScreen(
                            user : favorites[index],
                          ),
                        ),
                      ),
                      child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0, 
                          backgroundImage: AssetImage(images),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Text(
                          favorites[index],
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
