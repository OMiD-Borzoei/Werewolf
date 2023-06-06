// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:werewolf/main.dart';
import 'package:werewolf/shared/card.dart';
import 'package:werewolf/shared/settings.dart';

class FavDecks extends StatefulWidget {
  static Map picked = {
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

  const FavDecks({Key? key}) : super(key: key);

  @override
  _FavDecksState createState() => _FavDecksState();
}

class _FavDecksState extends State<FavDecks> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background2.jpg"),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            for (int i = 0; i < User.favDecks.length; i++)
              favDecks(User.favDecks[i], i),
            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setStat) {
                          return Center(
                            child: SizedBox(
                              width: Dev.wid,
                              height: Dev.hei / 1.5,
                              child: Column(
                                children: [
                                  Container(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        child: showCards(
                                            "Villager",
                                            FavDecks.picked['Villager'] == 0,
                                            FavDecks.picked['Villager']),
                                        onTap: () {
                                          addRole('Villager', 3);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCards(
                                            "Werewolf",
                                            FavDecks.picked["Werewolf"] == 0,
                                            FavDecks.picked['Werewolf']),
                                        onTap: () {
                                          addRole('Werewolf', 2);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCard(
                                            "Seer",
                                            FavDecks.picked["Seer"] == 0,
                                            false),
                                        onTap: () {
                                          addRole('Seer', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        child: showCard(
                                            "Robber",
                                            FavDecks.picked["Robber"] == 0,
                                            true),
                                        onTap: () {
                                          addRole('Robber', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCard(
                                            "TroubleMaker",
                                            FavDecks.picked["TroubleMaker"] ==
                                                0,
                                            true),
                                        onTap: () {
                                          addRole('TroubleMaker', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCard(
                                            "Insomniac",
                                            FavDecks.picked["Insomniac"] == 0,
                                            true),
                                        onTap: () {
                                          addRole('Insomniac', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCard(
                                            "Drunk",
                                            FavDecks.picked["Drunk"] == 0,
                                            true),
                                        onTap: () {
                                          addRole('Drunk', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCard(
                                            "Hunter",
                                            FavDecks.picked["Hunter"] == 0,
                                            true),
                                        onTap: () {
                                          addRole('Hunter', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        child: showCard(
                                            "Tanner",
                                            FavDecks.picked["Tanner"] == 0,
                                            false),
                                        onTap: () {
                                          addRole('Tanner', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCards(
                                            "Mason",
                                            FavDecks.picked["Mason"] == 0,
                                            FavDecks.picked['Mason']),
                                        onTap: () {
                                          addRole('Mason', 2);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCard(
                                            "Minion",
                                            FavDecks.picked["Minion"] == 0,
                                            false),
                                        onTap: () {
                                          addRole('Minion', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                      GestureDetector(
                                        child: showCard(
                                            "Doppelganger",
                                            FavDecks.picked["Doppelganger"] ==
                                                0,
                                            false),
                                        onTap: () {
                                          addRole('Doppelganger', 1);
                                          setStat(() {});
                                          //Game.roles[villager]+=1;
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            if (isLegal()) {
                                              List<String> l = [];
                                              for (var entry
                                                  in FavDecks.picked.entries) {
                                                for (int i = 0;
                                                    i < entry.value;
                                                    i++) {
                                                  l.add(entry.key);
                                                }
                                              }
                                              User.favDecks.add(l);
                                              MyApp.setSettings(
                                                  'FavDeck ' +
                                                      User.favDecks.length
                                                          .toString(),
                                                  l);
                                              Navigator.pop(context);
                                              setState(() {
                                                for (var entry in FavDecks
                                                    .picked.entries) {
                                                  FavDecks.picked[entry.key] =
                                                      0;
                                                }
                                              });
                                            }
                                          },
                                          child: Material(
                                            color: Colors.black.withOpacity(0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: isLegal()
                                                    ? MyTheme.matprimary
                                                    : Colors.red,
                                              ),
                                              height:
                                                  Dev.hei * 0.04509052 /*37*/,
                                              width: Dev.wid *
                                                  0.157986111122 /*65*/,
                                              child: const Center(
                                                child: Text(
                                                  'Okay',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )),
                                      ElevatedButton(
                                          onPressed: () {
                                            setStat(() {
                                              for (var entry
                                                  in FavDecks.picked.entries) {
                                                FavDecks.picked[entry.key] = 0;
                                              }
                                            });
                                          },
                                          child: const Text('Clear')),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      }).then((_) {
                    for (var entry in FavDecks.picked.entries) {
                      FavDecks.picked[entry.key] = 0;
                    }
                  });
                },
                child: const Text('Add!')),
          ],
        ),
        height: Dev.hei,
        width: Dev.wid,
      ),
    );
  }

  void addRole(name, max) {
    FavDecks.picked.update(
      name,
      (v) => v == max ? v = 0 : ++v,
    );
  }

  Widget favDecks(x, y) {
    if (x == null) return Container();
    return Column(children: [
      Text(
        'Favourite Deck #${y + 1}\n',
        style: const TextStyle(
          color: Colors.purple,
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Stack(
          children: [
            for (int i = 0; i < x.length; i++) card(x[i], i),
          ],
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            height: 30,
            width: 100,
            decoration: BoxDecoration(
              color: MyTheme.primary,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Text(
                (x.length - 3).toString() + ' People',
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            height: 30,
            width: 100,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'U Sure ? ',
                            style: TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.none,
                              fontSize: 16,
                            ),
                          ),
                          FloatingActionButton(
                              backgroundColor: Colors.orange.shade800,
                              onPressed: () {
                                User.favDecks.remove(x);
                                setState(() {
                                  Navigator.pop(context);
                                });
                              },
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.warning_amber_outlined,
                                      size: 40,
                                      color: Colors.white.withOpacity(0.2),
                                    ),
                                  ),
                                  const Center(
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  )
                                ],
                              )),
                          FloatingActionButton(
                            backgroundColor: Colors.green.shade800,
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'No',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              },
              child: const Text(
                'Remove',
              ),
            ),
          ),
        ],
      ),
      const Divider(
        height: 15,
        thickness: 1.5,
        color: Colors.white,
      ),
    ]);
  }

  Widget card(String s, int i) {
    String dir = "assets/images/" + s + ".jpg";
    return Container(
      margin: EdgeInsets.fromLTRB(i * 45.0, 0, 0, 0),
      height: 100,
      width: 60,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(dir), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(Settings.R),
      ),
    );
  }

  bool isLegal() {
    int x = 0;
    for (var entry in FavDecks.picked.entries)
      x += int.parse(entry.value.toString());
    return x <= 13 && x >= 6;
  }
}
