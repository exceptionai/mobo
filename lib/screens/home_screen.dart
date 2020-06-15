import 'package:flutter/material.dart';
import 'package:mobo/components/drawer_fiap_ex.dart';
import 'package:mobo/components/favorite_bots.dart';
import 'package:mobo/components/recents_chats.dart';

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
          
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30,),
          // CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
            color: const Color(0xfff2f9fb),
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
