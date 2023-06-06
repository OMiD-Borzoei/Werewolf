import 'package:flutter/material.dart';
import 'package:werewolf/main.dart';
import 'package:werewolf/shared/game.dart';
import 'package:werewolf/shared/settings.dart';

import 'giveroles.dart';

class Results extends StatefulWidget {
  const Results({Key? key}) : super(key: key);

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: DefaultTextStyle(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Winners'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Dev.wid / 3,
                    color: Colors.red,
                    child: Column(
                      children: [
                        const Center(
                          child: Text('Name'),
                        ),
                        const SizedBox(height: 30,),
                        for (int i = 0; i < Game.people; i++)
                          if (Game.players[i].haveWon)
                            Center(
                              child: Text('${Game.players[i].name}\n'),
                            )
                      ],
                    ),
                  ),
                  Container(
                    width: Dev.wid / 3,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        const Center(
                          child: Text('First Role'),
                        ),
                        const SizedBox(height: 30,),
                        for (int i = 0; i < Game.people; i++)
                          if (Game.players[i].haveWon)
                            Center(
                              child: Text(Game.firstPlayers[i].role+'\n'),
                            )
                      ],
                    ),
                  ),
                  Container(
                    width: Dev.wid / 3,
                    color: Colors.green,
                    child: Column(
                      children: [
                        const Center(
                          child: Text('Last Role'),
                        ),
                        const SizedBox(height: 30,),
                        for (int i = 0; i < Game.people; i++)
                          if (Game.players[i].haveWon)
                            Center(
                              child: Text(Game.players[i].role+'\n'),
                            )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Losers'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Dev.wid / 3,
                    color: Colors.red,
                    child: Column(
                      children: [
                        const Center(
                          child: Text('Name'),
                        ),
                        const SizedBox(height: 30,),
                        for (int i = 0; i < Game.people; i++)
                          if (!Game.players[i].haveWon)
                            Center(
                              child: Text('${Game.players[i].name}\n'),
                            )
                      ],
                    ),
                  ),
                  Container(
                    width: Dev.wid / 3,
                    color: Colors.blue,
                    child: Column(
                      children: [
                        const Center(
                          child: Text('First Role'),
                        ),
                        const SizedBox(height: 30,),
                        for (int i = 0; i < Game.people; i++)
                          if (!Game.players[i].haveWon)
                            Center(
                              child: Text(Game.firstPlayers[i].role+'\n'),
                            )
                      ],
                    ),
                  ),
                  Container(
                    width: Dev.wid / 3,
                    color: Colors.green,
                    child: Column(
                      children: [
                        const Center(
                          child: Text('Last Role'),
                        ),
                        const SizedBox(height: 30,),
                        for (int i = 0; i < Game.people; i++)
                          if (!Game.players[i].haveWon)
                            Center(
                              child: Text(Game.players[i].role+'\n'),
                            )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('What Happened At Night'),
                ],
              ),
              Text(NightActions.seerDid),
              Text(NightActions.robberDid),
              Text(NightActions.troublemakerDid),
              Text(NightActions.drunkDid),
              ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyApp()));
                  },
                  child: const Text('Go To First Page')),
              ElevatedButton(
                  onPressed: (){
                    Game.listRoles = Game.Start();
                    for (int i = 0; i <= Game.people; i++) {
                      Game.players[i].hasSeenCard = false;
                    }
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GiveRoles()));
                  },
                  child: const Text('Play Again')),



            ],
          ),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }


}
