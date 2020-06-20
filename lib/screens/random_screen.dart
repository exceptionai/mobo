import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobo/components/circular_progress_indicator_ex.dart';
import 'package:mobo/components/input_button_in_fiap_ex.dart';
import 'package:mobo/models/roommate_model.dart';
import 'package:mobo/repository/roommate_repository.dart';

class RandomScreen extends StatefulWidget {
  @override
  _RandomScreenState createState() => _RandomScreenState();
}

class _RandomScreenState extends State<RandomScreen> {
  @override
  bool isLoading = false;
  final random = Random();
  RoommateModel chosenOne = RoommateModel();

  void _generateChosenOne() async{
    setState(() {
      isLoading = true;
    });

    var aux = await RoommateRepository().getAllRoommatees();
    await Future.delayed(const Duration(seconds: 1));                        ;
    var i = random.nextInt(aux.length);
    chosenOne = aux[i];
    setState(() {
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios),
          color: Theme.of(context).primaryColor,
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
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey[400],
          ),
        ),
        
        elevation: 0.0,
      ),
      body:Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xffc1fcd3),Color(0xff0ccda3) ]
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.only(top:100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.0),),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            margin: EdgeInsets.all(25),
                            child: Text("""Sorteie uma pessoa que mora com você para fazer aquela tarefinha indesejada, como por exemplo lavar a louça ou levar o lixo pra fora.""",
                              style:TextStyle(
                                color: Colors.blueGrey[400],
                                fontSize: 22.0,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                         InkWell(
                          onTap : (){
                            if(isLoading == false)
                            _generateChosenOne();
                          },
                          child: InputButtonFiapEx("Que comesse os jogos!"),
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                 (chosenOne.name == null && isLoading == false) ? Container() : 
                 (isLoading) ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white),),) :
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(60.0),),
                      color: Colors.white,
                    ),   
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.only(
                      top: 8.0, 
                      bottom: 8.0,
                      left: 8.0,
                      right: 8.0
                    ),
                  padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                  child:Container(
                    child: Center(
                      child:Text(chosenOne.name,
                        style:TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 23.0,
                          fontWeight: FontWeight.w500,                         
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
      );
  }
}