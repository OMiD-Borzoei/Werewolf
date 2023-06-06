
import 'package:flutter/material.dart';
import 'package:werewolf/screens/night.dart';
import 'package:werewolf/shared/settings.dart';

import 'package:werewolf/shared/game.dart';

class GiveRoles extends StatefulWidget {
  const GiveRoles({Key? key}) : super(key: key);

  @override
  GiveRolesPage createState() => GiveRolesPage();
}

class GiveRolesPage extends State<GiveRoles> {
  int playersLeft = Game.people;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          playersRoles(),
          goToNight(),
        ],
      ),
    );
  }

  Widget playersRoles() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: const  BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background3.jpg' ),
          fit: BoxFit.cover,

        ),
      ),
      child: makePlayerWidgets(),
    );
  }
  Widget makePlayerWidgets(){
    return ListView(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0;
        Game.people % 3 == 0
            ? i < Game.people ~/ 3
            : i < Game.people ~/ 3 + 1;
        i++)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            for (int j = 1; (i) * 3 + j <= Game.people && j <= 3 ; j++)
              if(Game.players[i*3+j-1].hasSeenCard==false)
            //color: i % 2 == 1 ? MyTheme.primary : MyTheme.secondary,
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: i % 2 == 1
                        ? j == 2
                        ? Colors.black
                        : Colors.white
                        : j == 2
                        ? Colors.white
                        : Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: Dev.hei * 0.15,
                  //Dev.hei * 0.0609331,
                  width: Dev.wid / 3.9,
                  //Dev.wid / 4,
                  child: Center(
                    child: Text(Game.players[i * 3 + j - 1].name.toString(), style: TextStyle(
                      color: i % 2 == 1
                          ? j == 2
                          ? Colors.white
                          : Colors.black
                          : j == 2
                          ? Colors.black
                          : Colors.white,
                    ),),
                  ),
                ),
                onTap: () {

                  Player player = Game.players[i * 3 + j - 1];
                  String dir = 'assets/images/${player.role}.jpg';
                  if (!player.hasSeenCard) {
                    showDialog(
                        context: context,
                        builder: (context) => Center(
                            child: Container(
                              //color: Colors.black,
                              height: Dev.hei / 2,
                              width: Dev.wid / 1.6,
                              child: Column(
                                children: [
                                  /*const Text(
                                      'You Are: ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.green,
                                          decoration: TextDecoration.none),
                                    ),*/
                                  Center(
                                    child: Image.asset(dir),
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      }, child: const Text('I\'ve Memorized My Role'),
                                  )
                                ],
                              ),
                            )
                        ),

                    ).then((_) {
                      Game.players[i*3+j-1].hasSeenCard=true;
                      playersLeft--;
                      setState(() {});
                    });
                  }
                  setState(() {});
                },

              ),
          ]),
      ],
    );
  }
  Widget goToNight(){
    if(playersLeft==0){
      return GestureDetector(
        child: Center(
            child: Container(
              height: Dev.hei/2,
              width: Dev.wid/2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
                image: DecorationImage(
                    image: AssetImage('assets/images/Moon.jpg'),
                  fit: BoxFit.cover,
                )
              ),
              child: const Center(
                child: Text('\nIt\'s Time for Bed!', style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),),
              ),
          ),
        ),
        onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ExampleWidget()));
        },
      );
    }
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }
}
