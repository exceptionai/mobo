import 'package:flutter/material.dart';

class InputButtonFiapEx extends StatelessWidget {
  
  final String text;
  final Color color;
  final Widget leading;
  InputButtonFiapEx(this.text, {this.leading, this.color});

  @override
  Widget build(BuildContext context) {
    return (Container(
      padding: EdgeInsets.symmetric(horizontal:30),
      height: 60.0,
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: color == null? Theme.of(context).primaryColor: color,
        borderRadius: BorderRadius.all(const Radius.circular(30.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          this.leading != null ? Padding(padding: EdgeInsets.only(right: 20), child:this.leading) : Container(),
          Text(
            text,
            style: TextStyle(
              color:  color != null? Theme.of(context).primaryColor: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    ));
  }
}
