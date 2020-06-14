import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
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
          color: Colors.blue,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 10.0),
            itemCount: favorites.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35.0,
                    //backgroundImage: ,
                  ),
                  Text(favorites[index]),
                ],
              );
            }),
        ),
      ],
    );
  }
}
