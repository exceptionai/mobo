import 'package:flutter/material.dart';
import 'package:mobo/components/on_boarding/src/on_boarding_me.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: OnboardingMe(
      /// Number of Pages for the screens
      numOfPage: 4,

      /// No of colors you want for your screen
      noOfBackgroundColor: 4,

      /// List of background colors => In descending order
      bgColor: [
        Theme.of(context).accentColor,
        Theme.of(context).accentColor,
        Theme.of(context).accentColor,
        Theme.of(context).primaryColor,
      ],

      /// List of  Call-to-action action
      ctaText: [
        'Pular',
        'Começar'
      ],

      /// List that maps your screen content
      screenContent: [
        {
          "Scr 1 Heading" : "MOBO",
          "Scr 1 Sub Heading" : "Deborah Mort, também conhecida como Mobo irá trazer novas experiências para o usuário de forma amigável e divertida.",
          "Scr 1 Image Path" : "assets/images/bot(1)(1).png",
        },
        {
          "Scr 2 Heading" : "Receitas",
          "Scr 2 Sub Heading" : "Com a mobo você terá indicações de diversas receitas de dar água na boca.",
          "Scr 2 Image Path" : "assets/images/fork(1).png",
        },
        {
          "Scr 3 Heading" : "Novos companheiros!",
          "Scr 3 Sub Heading" : "A Mobo está chamando todos seus conhecidos para te conhecer, então logo mais novos bots estarão disponíveis.",
          "Scr 3 Image Path" : "assets/images/bot(2).png",
        },
        {
          "Scr 4 Heading" : "Tudo certo!",
          "Scr 4 Sub Heading" : "Comece agora a experimentar esta nova experiência.",
          "Scr 4 Image Path" : "assets/images/presenteicone.png",
        },
      ],

      /// Bool for Circle Page Indicator
      isPageIndicatorCircle: true,

      /// Home Screen Route that lands after on-boarding
      homeRoute: '/',
    ),
    );
  }
}