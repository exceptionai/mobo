import 'package:flutter/material.dart';

class InputButtonFiapEx extends StatelessWidget {
  
  final String text;
  InputButtonFiapEx(this.text);

  @override
  Widget build(BuildContext context) {
    return (Container(
      width: 320.0,
      height: 60.0,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.all(const Radius.circular(30.0)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.3,
        ),
      ),
    ));
  }
}
