//Flutter
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DrawerFiapEx extends StatefulWidget {

  final String route;

  const DrawerFiapEx({this.route});

  @override
  _DrawerFiapExState createState() => _DrawerFiapExState();
}

class _DrawerFiapExState extends State<DrawerFiapEx> {

  //TODO: buscar no repository a imagem
  String imagePath = 'assets/images/profilepic.jpg';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: <Widget>[
          Container( 
            color: Colors.white,
            ),
          _drawerContent(context),
        ],
      ),
    );
  }

  Widget _drawerContent(BuildContext context) {
    return SafeArea(
      
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 30),
            children: <Widget>[
              Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: InkWell(
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Theme.of(context).primaryColor,
                        backgroundImage: AssetImage(imagePath),
                      ),
                      onTap: (){
                        ImagePicker.pickImage(source: ImageSource.gallery).then((file){
                          if(file == null) return;
                          setState(() {
                            //TODO: salvar no repository a imagem
                            imagePath = file.path;
                          });
                        });
                      },
                    ),
                  ),  
                  Spacer(),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Icon(
                          Icons.exit_to_app,
                          size: 30,
                          color: Colors.blueGrey[700],//Theme.of(context).primaryColor,
                        ),
                  ),
                ],),

                
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Flávio Moreni',
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'GothamHTF',
                      fontWeight: FontWeight.w400,
                      color: Colors.blueGrey[400]),
                )
              ]),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.white10,
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                              child: Row(
                                children: <Widget>[

                    widget.route == '/' ? 
                    Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).primaryColor,
                    ) : Padding(padding: EdgeInsets.only(left:25),),
                                  Text(
                  'TODOS OS BOTS',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'GothamHTF',
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor),
                ),
                                ],
                              ),
                onTap: (){
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    widget.route == '/chat' ? 
                    Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).primaryColor,
                    ) : Padding(padding: EdgeInsets.only(left:25),),
                    
                    Container(
                      
                      child: Text(
                        'CONVERSAR COM MOBO',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'GothamHTF',
                            fontWeight: FontWeight.w400,
                            color:Colors.blueGrey[400]),
                      ),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.of(context).pushNamed('/chat');
                },
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    widget.route == '/roommate' ? 
                    Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).primaryColor,
                    ) : Padding(padding: EdgeInsets.only(left:25),),
                    
                    Container(
                      
                      child: Text(
                        'COMPANHEIROS',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'GothamHTF',
                            fontWeight: FontWeight.w400,
                            color: Colors.blueGrey[400]),
                      ),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.of(context).pushNamed('/roommate');
                },
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                child: Row(
                  children: <Widget>[
                    widget.route == '/random' ? 
                    Icon(
                      Icons.arrow_right,
                      color: Theme.of(context).primaryColor,
                    ) : Padding(padding: EdgeInsets.only(left:25),),
                    
                    Container(
                      
                      child: Text(
                        'SORTEAR COMPANHEIRO',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'GothamHTF',
                            fontWeight: FontWeight.w400,
                            color:Colors.blueGrey[400]),
                      ),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.of(context).pushNamed('/random');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _routeColor(String route, BuildContext context){
    if(widget.route == route){
      return Theme.of(context).primaryColor;
    }
    return Colors.white;
  }
}
