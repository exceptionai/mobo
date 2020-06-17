import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobo/components/circular_progress_indicator_ex.dart';
import 'package:mobo/models/roommate_model.dart';
import 'package:mobo/repository/roommate_repository.dart';

class RandomScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  @override
  bool isLoading = true;
  final random = Random();
  //List<RoommateModel> list = List();
  RoommateModel chosenOne = RoommateModel();

  void _generateChosenOne() async{

    setState(() {
      isLoading = true;
    });

    var aux = await RoommateRepository().getAllRoommatees();
    var i = random.nextInt(aux.length);
    chosenOne = aux[i];
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios),
          color: Colors.white,
          iconSize: 30.0,
          onPressed:(){
            Navigator.of(context).pushNamed('/');
          }, 
        ),
        centerTitle: true,
        title:Text(
          'Sorteio',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        
        elevation: 0.0,
      ),
      body:Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                FlatButton(
                  onPressed: (){
                      _generateChosenOne();
                  },
                  child: Text('Sortear',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,                
                    ),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                 (chosenOne.name == null) ? Container() : 
                 (isLoading) ? CircularProgressIndicatorEx() :
                  Container(
                  //width: MediaQuery.of(context).size.width * 0.8,
                    margin: EdgeInsets.only(
                      top: 8.0, 
                      bottom: 8.0,
                      left: 8.0,
                      right: 8.0
                    ),
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                  decoration: BoxDecoration(
                    color:Colors.grey[50],
                    ),
                  child:Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left:20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0),),
                        ),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Center(
                          child: Text(chosenOne.name,
                            style:TextStyle(
                              color: Colors.blueGrey[800],
                              fontSize: 23.0,
                              fontWeight: FontWeight.w500,
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
      );
  }
}