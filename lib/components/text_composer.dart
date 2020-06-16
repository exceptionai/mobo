import 'package:flutter/material.dart';

class TextComposer extends StatefulWidget {
  
  TextComposer(this.sendMessage);

  Function(String) sendMessage;

  @override
  _TextComposerState createState() => _TextComposerState();
}

class _TextComposerState extends State<TextComposer> {


  final TextEditingController _controller = TextEditingController();
  bool _isComposing = false;

  void _reset(){
     _controller.clear();
      setState(() {
        _isComposing = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 60.0,
      color: Colors.blueGrey[50],
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_camera),
            iconSize: 25.0,
            onPressed: (){
              
            },
            color: Colors.blueGrey,
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(
                hintText: "Enviar uma mensagem"
              ),
              onChanged: (text){
                setState((){
                   _isComposing = text.isNotEmpty;
                });
              },
              onSubmitted: (text){
                widget.sendMessage(text);
                _reset();
              },
            ),
          ),
          IconButton(
            icon:Icon(Icons.send),
            iconSize: 25.0,
            onPressed: _isComposing ? (){
              widget.sendMessage(_controller.text);
              _reset();
            } : null,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}