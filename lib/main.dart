import 'package:flutter/material.dart';
import 'package:mobo/screens/home_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOBO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Color(0xFFFEF9EB),
      ),
      home: HomeScreen()
    );
  }
}

