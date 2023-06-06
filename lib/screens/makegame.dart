import 'package:werewolf/shared/settings.dart';
import 'package:flutter/material.dart';
import 'package:werewolf/shared/game.dart';
import 'package:werewolf/shared/card.dart';
import 'giveroles.dart';

class MakeGame extends StatefulWidget {
  const MakeGame({Key? key}) : super(key: key);

  @override
  MakeGamePage createState() => MakeGamePage();
}

class MakeGamePage extends State<MakeGame> {
  List<String> lst = [];
  String dropDownValue = 'None';

  @override
  Widget build(BuildContext context) {
    if (lst.isEmpty) lst.add('None');
    for (int i = 0; i < User.favDecks.length; i++) {
      if (lst.contains('Favourite Deck #' + (i + 1).toString()) == false) {
        lst.add('Favourite Deck #' + (i + 1).toString());
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make The Game'),
        backgroundColor: Colors.black,
        actions: [
          DropdownButton(
            dropdownColor: Colors.black87,
            value: dropDownValue,
            style: const TextStyle(color: Colors.red),
            items: lst.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                onTap: () {
                  setState(() {
                    if (value != 'None') {
                      String nm = value.split("#")[1];
                      for (var key in Game.roles.keys) {
                        Game.roles[key] = 0;
                      }
                      for (String i in User.favDecks[int.parse(nm) - 1]) {
                        Game.roles.update(i, (value) => ++value);
                      }
                      Game.people=User.favDecks[int.parse(nm)-1].length-3;
                      Game.selected = Game.people+3;
                      print(Game.people);
                    }
                    else {
                      for (var key in Game.roles.keys) {
                        Game.roles[key] = 0;
                      }
                      Game.people=Settings.firstSelected;
                      Game.selected = 0;
                    }
                  });
                },
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue ?? 'None';
              });
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background2.jpg"),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            Container(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: showCards("Villager", Game.roles["Villager"] == 0,
                      Game.roles['Villager']),
                  onTap: () {
                    addRole('Villager', 3);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child: showCards("Werewolf", Game.roles["Werewolf"] == 0,
                      Game.roles['Werewolf']),
                  onTap: () {
                    addRole('Werewolf', 2);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child: showCard("Seer", Game.roles["Seer"] == 0, false),
                  onTap: () {
                    addRole('Seer', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: showCard("Robber", Game.roles["Robber"] == 0, true),
                  onTap: () {
                    addRole('Robber', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child: showCard(
                      "TroubleMaker", Game.roles["TroubleMaker"] == 0, true),
                  onTap: () {
                    addRole('TroubleMaker', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child:
                      showCard("Insomniac", Game.roles["Insomniac"] == 0, true),
                  onTap: () {
                    addRole('Insomniac', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child: showCard("Drunk", Game.roles["Drunk"] == 0, true),
                  onTap: () {
                    addRole('Drunk', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child: showCard("Hunter", Game.roles["Hunter"] == 0, true),
                  onTap: () {
                    addRole('Hunter', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: showCard("Tanner", Game.roles["Tanner"] == 0, false),
                  onTap: () {
                    addRole('Tanner', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child: showCards(
                      "Mason", Game.roles["Mason"] == 0, Game.roles['Mason']),
                  onTap: () {
                    addRole('Mason', 2);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child: showCard("Minion", Game.roles["Minion"] == 0, false),
                  onTap: () {
                    addRole('Minion', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
                GestureDetector(
                  child: showCard(
                      "Doppelganger", Game.roles["Doppelganger"] == 0, false),
                  onTap: () {
                    addRole('Doppelganger', 1);
                    setState(() {});
                    //Game.roles[villager]+=1;
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              getMessage(),
              style: TextStyle(
                  color: getMessage()[0] == 'Y' || getMessage()[0] == 'N'
                      ? Colors.green
                      : Colors.red),
            )),
            Row(
              children: [
                playersList(),
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 20, 20),
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                heroTag: '2',
                backgroundColor: canPlay() ? Colors.green : Colors.red,
                //foregroundColor: MyTheme.primary,
                icon: const Icon(
                  Icons.arrow_forward_ios,
                ),
                label: const Text(
                  'Start',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                onPressed: () {
                  if (canPlay()) {
                    for (var entry in Game.roles.entries) {
                      if (entry.key != 'Villager' &&
                          entry.key != 'Tanner' &&
                          entry.key != 'Hunter' &&
                          entry.value > 0) {
                        Game.toWakeUpRoles += 1;
                      }
                    }
                    Game.listRoles = Game.Start();
                    for (int i = 0; i <= Game.people; i++) {
                      Game.players[i].hasSeenCard = false;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GiveRoles()));
                  }
                },
              ),
            ),
          ],
        ),
        height: Dev.hei,
        width: Dev.wid,
      ),
    );
  }

  void addRole(name, max) {
    if (Game.roles[name] == max) {
      Game.selected -= int.parse(max.toString());
    } else {
      Game.selected++;
    }
    Game.roles.update(
      name,
      (v) => v == max ? v = 0 : ++v,
    );
  }

  bool allPlayersIn() {
    for (int i = 1; i < Game.people; i++) {
      if (Game.players[i].name == '') {
        return false;
      }
    }
    return true;
  }

  String getMessage() {
    bool isOne = Game.selected - (Game.people + 3) == 1 ||
        Game.people + 3 - Game.selected == 1;
    if (Game.people + 3 < Game.selected) {
      if (isOne) {
        return 'Remove ' +
            (Game.selected - Game.people - 3).toString() +
            " Role From Your Game";
      } else {
        return 'Remove ' +
            (Game.selected - Game.people - 3).toString() +
            " Roles From Your Game";
      }
    } else if (Game.people + 3 > Game.selected) {
      if (isOne) {
        return 'Add ' +
            (Game.people + 3 - Game.selected).toString() +
            " More Role to Your Game";
      } else {
        return 'Add ' +
            (Game.people + 3 - Game.selected).toString() +
            " More Roles to Your Game";
      }
    } else if (allPlayersIn() == false) {
      return 'Now You Need to Enter Name of The Players';
    }
    return 'You Are Ready To Go';
  }

  bool canPlay() {
    if (getMessage()[0] == 'Y' && allPlayersIn()) {
      return true;
    }
    return false;
  }

  Widget playersList() {
    return Container(
      width: Dev.wid,
      height: Dev.hei / 4,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      //color: Colors.grey,
      child: ListView(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0;
              Game.people % 3 == 0
                  ? i < Game.people ~/ 3
                  : i < Game.people ~/ 3 + 1;
              i++)
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              for (int j = 1; (i) * 3 + j <= Game.people && j <= 3; j++)
                Container(
                  height: Dev.hei * 0.0609331,
                  width: Dev.wid / 4,
                  //color: i % 2 == 1 ? MyTheme.primary : MyTheme.secondary,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.orange,
                    ),
                    decoration: InputDecoration(
                      hintText: Game.players[(i * 3 + j) - 1].name == ''
                          ? 'Enter a Name'
                          : Game.players[(i * 3 + j) - 1].name,
                      hintStyle: TextStyle(
                          color: Game.players[(i * 3 + j) - 1].name == ''
                              ? Colors.white
                              : Colors.orange),
                    ),
                    onChanged: (String value) {
                      Game.players[(i * 3 + j) - 1] = Player(value);
                      setState(() {});
                    },
                  ),
                ),
            ]),
        ],
      ),
    );
  }

  Widget bottomSheet(context) {
    return Container(
      color: Colors.black87,
      height: 210,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "How Many Players ? ",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListView(
            //physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: [
              for (int i = 3; i < 11; i++)
                SizedBox(
                  height: 70,
                  child: GestureDetector(
                    child: Center(
                      child: Text(
                        i.toString(),
                        style:
                            const TextStyle(fontSize: 19, color: Colors.yellow),
                      ),
                    ),
                    onTap: () {
                      Game.people = i;
                      setState(() {});
                    },
                  ),
                )
            ],
          ),
        ],
      ),
    );
  }
}
