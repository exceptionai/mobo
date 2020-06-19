import 'dart:async';

import 'package:fade/fade.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobo/models/message_history_model.dart';
import 'package:mobo/repository/message_history_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageCardEx extends StatefulWidget {

  final MessageHistoryModel model;
  final bool isLast;
  final bool isLoading;

  MessageCardEx({Key key,@required this.model, @required this.isLast, @required this.isLoading}) : super(key: key);

  @override
  _MessageCardExState createState() => _MessageCardExState();
}

class _MessageCardExState extends State<MessageCardEx> {

  bool _visible = false;
  bool _typing = true;
  Timer timer;
  String _loadingDot = '';


  get visible{
    return _visible;
  }

  set visible(bool visible){
    setState(() {
      _visible = visible;
    });
  }

  get loadingDot{
    return _loadingDot;
  }

  set loadingDot(String loadingDot){
    setState(() {
      _loadingDot = loadingDot;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fadeAnimation();
  }

    void _fadeAnimation()async{
      await Future.delayed(Duration(milliseconds: 300));
      setState(() {
        visible = true;
      });
    }

  @override
  Widget build(BuildContext context) {
    bool isMe = (widget.model.fromUser == 1);
    bool isLiked = (widget.model.favorite == 1);
    return Column(
      children: <Widget>[
        Fade(
          visible: visible,
          duration: Duration(seconds: widget.isLast ? 1 : 0),
                  child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                margin: isMe ? EdgeInsets.only(
                  top: 8.0, 
                  bottom: 8.0,
                  left: 80.0,
                  right: 20.0
                ) : EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 20.0
                ),
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                decoration: BoxDecoration(
                  color: isMe ? Colors.white : Colors.green[50],
                  borderRadius: BorderRadius.all(Radius.circular(15.0),),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.model.registerHour != null ? widget.model.registerHour : ' ' ,
                      style:TextStyle(
                        color: Colors.blueGrey[400],
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    widget.model.content.startsWith("http") ?
                    InkWell(
                      onTap: (){
                        launch(widget.model.content);
                      },
                      child: Text(widget.model.content,
                        style:TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ) :
                    Text(widget.model.content,
                      style:TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              isMe ? SizedBox.shrink() : IconButton(
                icon: isLiked ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                iconSize: 30.0,
                color: isLiked ? Colors.redAccent[100] : Colors.blueGrey,
                onPressed: (){
                  _changeFavoriteStatus(widget.model);
                },
              ),
            ],
          ),
        ),

          _buildTipingMessage()
      ],
    );
    
  }


  void _changeFavoriteStatus(MessageHistoryModel model) async{
    if(model.favorite == 1){
      model.favorite = 0;
    }else{
      model.favorite = 1;
    }
    await MessageHistoryRepository().updateMessageHistory(model);
    setState(() {
      
    });
  }  


  _updateTypingDot() async{
    this.timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
      if(!widget.isLoading){
        timer.cancel();
        loadingDot = '';
        this.timer = null;
        return;
      }
      if(loadingDot.length == 3){
        loadingDot = '';
      }
      loadingDot += '.';
    });
  }

  Widget _buildTipingMessage(){
    if(this.timer == null){
      _updateTypingDot();
    }
    
    
    return Fade(
          visible: widget.isLoading && visible && widget.isLast,
          duration: Duration(milliseconds: 600),
          child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            margin: EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 20.0
            ),
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.all(Radius.circular(15.0),),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(DateFormat('hh:mm').format(DateTime.now()),
                  style:TextStyle(
                    color: Colors.blueGrey[400],
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(loadingDot,
                  style:TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}