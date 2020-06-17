import 'package:flutter/material.dart';
import 'package:mobo/models/roommate_model.dart';

class InsertRoommate extends StatefulWidget {
  
  InsertRoommate(this._saveRoommate);

  Function(String) _saveRoommate;
  @override
  _InsertRoommateState createState() => _InsertRoommateState();
}

class _InsertRoommateState extends State<InsertRoommate> {
  
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
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[70],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 15  ),
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration.collapsed(
                  hintText: "Adicionar um amigo"
                ),
                onChanged: (text){
                  setState((){
                     _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: (text){
                  widget._saveRoommate(text);
                  _reset();
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              color: Theme.of(context).primaryColor,
              iconSize:45.0,
              onPressed: _isComposing ? () async{
                await widget._saveRoommate(_controller.text);
                _reset();
              } : null,
            ),
            
          ],
        ),
      ),
    );
  }
}