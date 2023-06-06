import 'package:werewolf/shared/settings.dart';
import 'package:flutter/material.dart';
import 'package:werewolf/screens/favourite_decks.dart';

Widget showCard(dir, isDark, isMid) {
  dir = isDark
      ? "assets/images/" + dir + "_dark.jpg"
      : "assets/images/" + dir + ".jpg";
  return Container(
    height: isMid ? Settings.cardHM : Settings.cardH,
    width: isMid ? Settings.cardWM : Settings.cardW,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(dir), fit: BoxFit.fill),
      borderRadius: BorderRadius.circular(Settings.R),
    ),
  );
}

Widget showCards(dir, isDark, nm) {
  dir = isDark
      ? "assets/images/" + dir + "_dark.jpg"
      : nm == 1
          ? "assets/images/" + dir + ".jpg"
          : "assets/images/" + dir + nm.toString() + ".jpg";
  return Container(
    height: Settings.cardH,
    width: nm == 1 || nm == 0
        ? Settings.cardW
        : nm == 2
            ? Settings.cardW2
            : Settings.cardW3,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(dir), fit: BoxFit.fill),
      borderRadius: BorderRadius.circular(Settings.R),
    ),
  );
}


