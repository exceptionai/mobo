import 'package:flutter/material.dart';
import 'package:mobo/repository/roommate_repository.dart';
import 'package:mobo/screens/chat_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobo app',
      theme: ThemeData(
        primarySwatch: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.green,
        ),
      ),
      home: ChatScreen(),
    );
  }
}

