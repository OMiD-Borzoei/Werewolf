import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/services.dart';

class Dev {
  static double hei=0;
  //820.57142857142857
  static double wid=0;
  //411.42857142857142

}

class MyTheme {
  static const MaterialColor matprimary = Colors.deepPurple;
  static const Color primary = Colors.deepPurple;
  static const MaterialColor matsecondary = Colors.deepOrange;
  static const Color secondary = Colors.deepOrange;
}

class Settings {
    static const double R = 10;

    static  double cardW = Dev.wid*0.226140; //93
    static  double cardW2 = Dev.wid*0.30625; //126
    static  double cardW3 = Dev.wid*0.371875; //153
    static  double cardH = Dev.hei*0.158426; //130

    static double cardWM = Dev.wid*0.194;//80;
    static double cardHM = Dev.hei*0.141;//116;

    static String language = '';
    static double werewolfTime = 10;
    static double minionTime = 10;
    static double seerTime = 10;
    static double robberTime = 10;
    static double troublemakerTime = 10;
    static double drunkTime = 10;
    static double insomniacTime = 10;
    static double all = 10;
    static int favDeckLen = 0;
    static int firstSelected = 6;
    static double voteTime = 3;


    static Duration sleepDuration = const Duration(seconds: 10);
}


onClick(){
  SystemSound.play(SystemSoundType.click);
}

class User {
  static List<List<String>> favDecks = List.generate(0, (index) =>
      List.generate(0, (index) => '', growable: true),
      growable: true);
}




