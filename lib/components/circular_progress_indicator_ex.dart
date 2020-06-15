import 'package:flutter/material.dart';

class CircularProgressIndicatorEx extends StatelessWidget {
  const CircularProgressIndicatorEx({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),),);
  }
}