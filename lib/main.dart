import 'package:flutter/material.dart';
import 'package:mobo/screens/chat_screen.dart';
import 'package:mobo/screens/home_screen.dart';
import 'package:mobo/screens/login_screen.dart';
import 'package:mobo/screens/onboarding_screen.dart';
import 'package:mobo/screens/random_screen.dart';
import 'package:mobo/screens/roommate_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOBO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xff1bea9f),
        accentColor: const Color(0xff151819),
      ),
      onGenerateRoute: (RouteSettings settings){
        switch (settings.name) {

          case '/onboarding':
            return  MaterialPageRoute(
              builder: (_) => OnBoardingScreen(),
              settings: settings,
            );

          case '/':
            return MaterialPageRoute(
              builder: (_) => HomeScreen(),
              settings: settings,
            );

          case '/login':
            return MyCustomRoute(
              builder: (_) => LoginScreen(),
              settings: settings
            );
          case '/chat':
            return  SlideTransitionRoute(
              route: ChatScreen()
            );
          case '/roommate':
            return  MaterialPageRoute(
              builder: (_) => RoommateScreen(),
              settings: settings,
            );
          case '/random':
            return  MaterialPageRoute(
              builder: (_) => RandomScreen(),
              settings: settings,
            );
          default: 
            return MaterialPageRoute(
              builder: (_) => LoginScreen(),
              settings: settings,
            );
        }
      },
      
      initialRoute: '/login'
    );
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == '/login') return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}

class SlideTransitionRoute extends PageRouteBuilder{
  Widget route;
  SlideTransitionRoute({@required this.route}) : super(
    pageBuilder: (BuildContext context, Animation<double> animation,Animation<double> secondaryAnimation){
      return route;
    },
    transitionDuration: Duration(milliseconds: 700),
    transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
      Animation<Offset> custom = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0)).animate(animation);
      return SlideTransition(
        position: custom,
        child: child,
      );
    }
  );
}


