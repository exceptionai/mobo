import 'package:flutter/material.dart';
import 'package:mobo/components/drawer_fiap_ex.dart';
import 'package:mobo/widgets/category_selector.dart';
import 'package:mobo/widgets/favorite_bots.dart';
import 'package:mobo/widgets/recents_chats.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: DrawerFiapEx(route: '/',),
      appBar: AppBar(
        title: Text(
          'Conversas',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  FavoriteBots(),
                  RecentsChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
