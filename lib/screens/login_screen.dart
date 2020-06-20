
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobo/animations/login_animation.dart';
import 'package:mobo/components/form_container_fiap_ex.dart';
import 'package:mobo/components/input_button_in_fiap_ex.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  GoogleSignInAccount googleUser;

  AnimationController _loginButtonController;
  var animationStatus = 0;
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
        googleUser = account;
    });

    _loginButtonController = AnimationController(
        duration: Duration(milliseconds: 3000), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      print('sucess');
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.4;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (
      Scaffold(
        resizeToAvoidBottomPadding: false,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: ExactAssetImage('assets/images/login.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: <Color>[
                  const Color.fromRGBO(62, 76, 109, 0.3),
                  const Color.fromRGBO(51, 51, 63, 0.7),
                ],
                stops: [0.2, 1.0],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
              )),
              child: ClipRRect(
                              child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                child: Container(
                    child: ListView(
                      padding: const EdgeInsets.all(0.0),
                      children: <Widget>[
                        Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                SizedBox(height: 100,),
                                Image.asset('assets/images/mobologowhite.png',width: 300,),
                                SizedBox(height: 25,),
                                Image.asset('assets/images/exceptionlogo(3).png',width: 110,),
                                SizedBox(height: 70,),
                                

                                FormContainerFiapEx(),
                                SizedBox(height: 30,),

                                Padding(padding: EdgeInsets.only(top:160.0,),)
                              ],
                            ),
                            animationStatus == 0
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal:15.0),
                                  child: Column(
                                    children: <Widget>[
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              animationStatus = 1;
                                            });
                                            _playAnimation();
                                          },
                                          child: InputButtonFiapEx("Entrar")),
                                        Container(
                              margin: EdgeInsets.only(top: 30),
                              child: InkWell(
                                  onTap: ()async{

                                    await _handleSignIn();

                                              setState(() {
                                                animationStatus = 1;
                                              });
                                    _playAnimation();
                                  },
                                  child: InputButtonFiapEx("Entrar com Google", color: Colors.white,leading: Image.network('https://cdn.freebiesupply.com/logos/thumbs/2x/google-icon-logo.png', width: 40,),),
                              ),
                            )
                                    ],
                                  ),
                                )
                                : LoginAnimation(
                                    buttonController:
                                        _loginButtonController.view),
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ))),
    ));
  }
}
