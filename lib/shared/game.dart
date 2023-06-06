import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Game {
  static int selected = 0;
  static int people = 8;
  static String whoIsInsomniac = '';
  static Player executed = Player('');

  // ignore: prefer_typing_uninitialized_variables
  static List<Player> firstPlayers =
  List.generate(11, (int index) => Player(''), growable: true);
  static List<Player> players =
      List.generate(11, (int index) => Player(''), growable: true);

  static List<String> rolesInOrder = [
    'Doppelganger',
    'Werewolf',
    'Minion',
    'Mason',
    'Seer',
    'Robber',
    'TroubleMaker',
    'Drunk',
    'Insomniac'
  ];
  static int toWakeUpRoles = 0;

  // ignore: prefer_typing_uninitialized_variables
  static var listRoles;

  static var roles = {
    'Villager': 0,
    'Werewolf': 0,
    'Seer': 0,
    'Robber': 0,
    'TroubleMaker': 0,
    'Tanner': 0,
    'Drunk': 0,
    'Hunter': 0,
    'Mason': 0,
    'Insomniac': 0,
    'Minion': 0,
    'Doppelganger': 0,
  };


  static List<String> centerRoles =
  List.generate(3, (index) => index.toString());

  static int getRoles() {
    int s = 0;
    // ignore: curly_braces_in_flow_control_structures
    for (int v in Game.roles.values) s += v;
    return s;
  }

  // ignore: non_constant_identifier_names
  static List<String> Start() {
    List<String> listRoles = List.generate(0, (index) => index.toString(), growable: true);
    for (var entry in Game.roles.entries) {
      for (int i = 1; i <= entry.value; i++) {
        listRoles.add(entry.key);
      }
    }
    for (int i = 0; i <= 13; i++) {
      listRoles.shuffle();
    }

    for (int i = 0; i < 3; i++) {
      centerRoles[i] = listRoles[i];
    }

    for (int i = 0; i < listRoles.length - 3; i++) {
      Game.players[i].role = listRoles[i + 3];
      Game.firstPlayers[i].role = listRoles[i+3];
      Game.firstPlayers[i].name = Game.players[i].name;
      if (Game.players[i].role == 'Insomniac') {
        whoIsInsomniac = Game.players[i].name;
      }
    }
    printAll();
    NightActions.drunkDid = '';
    NightActions.robberDid = '';
    NightActions.seerDid = '';
    NightActions.troublemakerDid = '';

    return listRoles;
  }

  static void whoHasWon() {
    for(int i=0;i<Game.people;i++) {
      Game.players[i].haveWon = false;
    }
    if (executed.name == ''){
      for(int i=0;i<Game.people;i++){
        if(Game.players[i].role=='Werewolf' || Game.players[i].role=='Minion'){
          for(int j=0;j<Game.people;j++){
            if(Game.players[j].role=='Werewolf' || Game.players[j].role=='Minion'){
              Game.players[j].haveWon=true;
            }
          }
          return;
        }
      }
      for(int i=0;i<Game.people;i++) {
        Game.players[i].haveWon=true;
      }
    }
    else if (executed.role == 'Werewolf') {
      for (int i = 0; i < Game.people; i++) {
        if (Game.players[i].role != 'Werewolf' &&
            Game.players[i].role != 'Minion') {
          Game.players[i].haveWon = true;
        }
      }
    }
    else if (executed.role == 'Tanner') {
      for (int i = 0; i < Game.people; i++) {
        if (Game.players[i].role == 'Tanner') Game.players[i].haveWon = true;
      }
    }
    else {
      for (int i = 0; i < Game.people; i++) {
        if (Game.players[i].role == 'Werewolf' ||
            Game.players[i].role == 'Minion') {
          Game.players[i].haveWon = true;
        }
      }
    }
  }

  static void makeNewGame() {
    whoIsInsomniac = '';
    Game.selected = 0;
    Game.players = List.generate(11, (int index) => Player(''), growable: true);
    Game.firstPlayers = List.generate(11, (int index) => Player(''), growable: true);
    Game.roles = {
      'Villager': 0,
      'Werewolf': 0,
      'Seer': 0,
      'Robber': 0,
      'TroubleMaker': 0,
      'Tanner': 0,
      'Drunk': 0,
      'Hunter': 0,
      'Mason': 0,
      'Insomniac': 0,
      'Minion': 0,
      'Doppelganger': 0,
    };
  }
}

class Player {
  Player(this.name);

  String name = '';
  String role = '';
  bool hasSeenCard = false;
  bool haveWon = false;
  bool isSelected = false;

  static Container getPlayerContainer(nm) {
    return Container(
      height: 50,
      width: 50,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        //decoration: const InputDecoration(
        //),

        //onChanged: ,
      ),
    );
  }
}

void printAll() {
  for (int i = 0; i < Game.people; i++) {
    debugPrint(Game.players[i].name + "   :   " + Game.players[i].role);
  }
  for (int i = 0; i < 3; i++) {
    debugPrint(i.toString() + "   :   " + Game.centerRoles[i]);
  }
}

class NightActions {
  static String seerDid = '';
  static String troublemakerDid = '';
  static String robberDid = '';
  static String drunkDid = '';
}
