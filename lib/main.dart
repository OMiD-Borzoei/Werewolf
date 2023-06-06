import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:werewolf/screens/favourite_decks.dart';
import 'package:werewolf/screens/how_to_play.dart';
import 'package:werewolf/screens/settings.dart';
import 'package:werewolf/shared/game.dart';
import 'package:werewolf/shared/settings.dart';
import 'screens/makegame.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final prefs = SharedPreferences.getInstance();

  Future<void> getSettings() async {
    final prefs = await SharedPreferences.getInstance();
    Settings.werewolfTime = (prefs.getInt('werewolfTime') ?? 10).toDouble();
    Settings.minionTime = (prefs.getInt('minionTime') ?? 10).toDouble();
    Settings.seerTime = (prefs.getInt('seerTime') ?? 10).toDouble();
    Settings.robberTime = (prefs.getInt('robberTime') ?? 10).toDouble();
    Settings.troublemakerTime =
        (prefs.getInt('troublemakerTime') ?? 15).toDouble();
    Settings.drunkTime = (prefs.getInt('drunkTime') ?? 10).toDouble();
    Settings.insomniacTime = (prefs.getInt('insomniacTime') ?? 10).toDouble();
    Settings.all = (prefs.getInt('all') ?? 10).toDouble();
    Settings.favDeckLen = (prefs.getInt('favDeckLen')) ?? 0;
    Settings.voteTime = ((prefs.getInt('voteTime')) ?? 3).toDouble();
    if (User.favDecks.isEmpty) {
      for (int i = 0; i < Settings.favDeckLen; i++) {
        User.favDecks
            .add(prefs.getStringList('FavDeck ' + (i + 1).toString()) ?? []);
      }
    }
  }

  static Future<void> setSettings(key, value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
      prefs.setInt('favDeckLen', User.favDecks.length);
    }
  }

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    getSettings();
    return MaterialApp(
      title: 'Werewolf',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var physicalScreenSize = window.physicalSize;
  var physicalWidth = window.physicalSize.width;
  var physicalHeight = window.physicalSize.height;

  @override
  Widget build(BuildContext context) {
    Dev.hei = MediaQuery.of(context).size.height;
    Dev.wid = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        height: Dev.hei,
        width: Dev.wid,
        //margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background1.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                margin:
                    EdgeInsets.fromLTRB(0, Dev.hei * 0.08, Dev.wid * 0.58, 0),
                height: Dev.wid * 0.243056,
                width: Dev.wid * 0.243056,
                //color: MyTheme.secondary,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/images/claw.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Create\nNew Game',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.secondary,
                    ),
                  ),
                ),
              ),
              onTap: () {
                onClick();
                Game.people = Settings.firstSelected;
                Game.makeNewGame();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MakeGame()));
              },
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(60, 20, 0, 0),
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: Colors.blueGrey, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        Settings.firstSelected.toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  onTap: () {
                    _bottomSheet(context);
                  },
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: 50,
                  width: 60,
                  //decoration: const BoxDecoration(
                  //color: Colors.blueGrey, shape: BoxShape.circle),
                  child: const Center(
                    child: Text(
                      'People',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: myDrawer(),
    );
  }

  void _bottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return CupertinoPicker(
            backgroundColor: Colors.black87,
            itemExtent: 40.0,
            onSelectedItemChanged: (int sl) {
              setState(() {
                Settings.firstSelected = sl + 3;
              });
            },
            magnification: 1.7,
            diameterRatio: 0.85,
            squeeze: 0.8,
            useMagnifier: true,
            selectionOverlay: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                border: Border.all(
                  color: Colors.red.shade700,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(19),
              ),
            ),
            children: [
              for (int i = 3; i < 11; i++)
                Text(
                  i.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellow.shade700,
                  ),
                ),
            ],
          );
        });
  }
}

// ignore: camel_case_types
class myDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
      );

  Widget buildMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SetTings()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Manage Favourite Decks'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FavDecks()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.question_mark
                //IconData(0xf045e)
                ),
            title: const Text('How To Play'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HowToPlay()));
            },
          ),
        ],
      );
}
