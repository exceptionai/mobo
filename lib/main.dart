import 'package:flutter/material.dart';
import 'package:mobo/screens/chat_screen.dart';
import 'package:mobo/screens/home_screen.dart';
import 'package:mobo/screens/login_screen.dart';
import 'package:mobo/screens/onboarding_screen.dart';
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
        primaryColor: const Color(0xff239b55),
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
            return  MaterialPageRoute(
              builder: (_) => ChatScreen(),
              settings: settings,
            );
          case '/roommate':
            return  MaterialPageRoute(
              builder: (_) => RoommateScreen(),
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