import 'dart:async';
import 'dart:math';

import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:werewolf/shared/settings.dart';

import 'package:werewolf/shared/game.dart';

import 'day.dart';

void main() {
  runApp(ExampleWidget());
}

class ExampleWidget extends StatefulWidget {
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  int length = Game.people;

  double innerSpacingDivider = 10;
  double radiusOfItemDivider = 6;
  double centerWidgetRadiusDivider = 3;

  //AudioPlayer audioPlugin = AudioPlayer();

  int howMuch = 0;

  double startAngleDeg = -90;
  double totalArchDeg = 360;
  bool isClockwise = true;
  bool canOutBeSeen = false;
  bool midCanBeSeen = false;
  int midHowMuchCanBeSeen = 0;
  late double wid;
  final DateTime start = DateTime.now();

  var player = AudioPlayer();
  int selected = 0;
  bool haveDrunkExchanged = false;
  List<Player> exchangedPlayers = [Player(''), Player('')];
  String currentRole = '';
  bool dialogIsClosed = true;
  String isRed = '';
  int timeLeft = 5;

  // ignore: prefer_typing_uninitialized_variables
  var timer;

  // ignore: prefer_typing_uninitialized_variables
  var dialogContext;
  bool isPopped = false;

  @override
  void initState() {
    god();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    player.stop();
    try {
      timer.cancel();
    } catch (_) {}
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dialogContext = context;
    wid = MediaQuery.of(context).size.width / 2;
    isPopped = false;
    return WillPopScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: AnimatedContainer(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: const Text(
                            'Center Radius',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          subtitle: Slider(
                            min: 1,
                            max: 5,
                            divisions: 16,
                            label: centerWidgetRadiusDivider.toStringAsFixed(2),
                            value: centerWidgetRadiusDivider,
                            onChanged: (newVal) => setState(
                                () => centerWidgetRadiusDivider = newVal),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Item Radius',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          subtitle: Slider(
                            // divisions: 18,
                            label: radiusOfItemDivider.toStringAsFixed(2),
                            value: radiusOfItemDivider,
                            min: 2,
                            max: 20,
                            onChanged: (newVal) =>
                                setState(() => radiusOfItemDivider = newVal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  table(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          title: const Text(
                            'Angle',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                          subtitle: Slider(
                            min: -360,
                            max: 360,
                            label: startAngleDeg.toStringAsFixed(2),
                            value: startAngleDeg,
                            onChanged: (newVal) =>
                                setState(() => startAngleDeg = newVal),
                          ),
                        ),
                        /*ElevatedButton(onPressed: (){_executeFuture=false;}, child: const Text('I\'m Done!'))*/
                      ],
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Table$isRed.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              duration: const Duration(milliseconds: 500),
            ),
          ),
        ),
        onWillPop: () {
          isPopped = true;
          //player.stop();
          return Future.value(true);
        });
  }

  Widget showBackCard(Player player, canBeSeen, context, focus) {
    String role = player.role;
    String focused = focus ? 'Focused' : '';
    int idx = Game.players.indexOf(player);
    bool sl = Game.players[idx].isSelected;
    return GestureDetector(
      child: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Back$focused.jpg'),
                  fit: BoxFit.cover,
                ),
                //borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              player.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              player.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        {
          currentRole != 'TroubleMaker'
              ? showDialog(
                  context: context,
                  builder: (context) {
                    dialogIsClosed = false;
                    dialogContext = context;
                    return Center(
                        child: SizedBox(
                      height: Dev.hei,
                      width: Dev.wid / 1.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: canBeSeen
                                ? Image.asset('assets/images/$role.jpg')
                                : const Text(
                                    'You Are Not Allowed To See The Card',
                                    style: TextStyle(color: Colors.red),
                                  ),
                          ),
                          canBeSeen
                              ? ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child:
                                      const Text('I\'ve Memorised Their Role'),
                                )
                              : const SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                        ],
                      ),
                    ));
                  },
                ).then((_) => dialogIsClosed = true)
              : {};
          setState(() {
            if (currentRole == 'Seer') {
              String seer = getRoleName('Seer');
              midHowMuchCanBeSeen = 0;
              midCanBeSeen = false;
              NightActions.seerDid =
                  '$seer The Seer Picked ${player.name}\'s Card and Saw ${player.role}';
            }
            if (currentRole == 'Robber') {
              String robber = getRoleName('Robber');
              int robberIndex = 0;
              int plIndex = 0;
              for (int i = 0; i < Game.players.length; i++) {
                if (Game.firstPlayers[i].role == 'Robber') robberIndex = i;
                if (Game.firstPlayers[i].role == player.role) plIndex = i;
              }
              Game.players[robberIndex].role = player.role;
              Game.players[plIndex].role = 'Robber';
              NightActions.robberDid =
              '$robber the Robber Picked ${player.name}\'s Card and Became ${Game.players[robberIndex].role}';
            }
            if (currentRole == 'TroubleMaker') {
              if (selected < 2 || sl == true) {
                Game.players[idx].isSelected = !sl;
                selected += sl == false
                    ? 1
                    : selected == 0
                        ? 0
                        : -1;
                if (sl == false) {
                  fill(player);
                } else {
                  empty(player);
                }
              }
            }
            canOutBeSeen = false;
          });
        }
      },
    );
  }

  Widget showMiddleCard(nm, canBeSeen, context, h) {
    return GestureDetector(
      child: Container(
        height: h / 2.5,
        width: h / 2.5,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Back.jpg'),
          ),
        ),
        child: Center(
          child: Text(
            nm.toString(),
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              dialogContext = context;
              dialogIsClosed = false;
              return SizedBox(
                height: Dev.hei,
                width: Dev.wid / 1.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: canBeSeen
                            ? Image.asset(
                                'assets/images/${Game.centerRoles[nm]}.jpg')
                            : currentRole == 'Drunk'
                                ? Text(
                                    'You\'ve Exchanged Your Card With Middle Card Number $nm',
                                    style: const TextStyle(color: Colors.green),
                                  )
                                : const Text(
                                    'You Are Not Allowed To See The Card',
                                    style: TextStyle(color: Colors.red),
                                  )),
                    canBeSeen || currentRole == 'Drunk'
                        ? ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Okay'),
                          )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          ),
                  ],
                ),
              );
            }).then((_) => dialogIsClosed = true);
        setState(() {
          if (currentRole == 'Seer') {
            String seer = getRoleName('Seer');
            if(NightActions.seerDid==''){
              NightActions.seerDid = '$seer The Seer Picked Middle Card Number $nm and Saw ${Game.centerRoles[nm]}';
            }
            else{
              NightActions.seerDid += '\n$seer The Seer Also Picked Middle Card Number $nm and Saw ${Game.centerRoles[nm]}';
            }
            canOutBeSeen = false;
          }
          if (currentRole == 'Drunk') {
            String drunk = getRoleName('Drunk');
            NightActions.drunkDid = '$drunk The Drunk Picked Middle Card Number $nm and Became ${Game.centerRoles[nm]}';
            if (haveDrunkExchanged == false) {
              for (int i = 0; i < Game.people; i++) {
                if (Game.firstPlayers[i].role == 'Drunk') {
                  Game.players[i].role = Game.centerRoles[nm];
                  Game.centerRoles[nm] = 'Drunk';
                }
              }
            }
            haveDrunkExchanged = true;
          }
          canBeSeen ? midHowMuchCanBeSeen-- : {};
          midCanBeSeen = midHowMuchCanBeSeen == 0 ? false : true;
        });
      },
    );
  }

  Widget table() {
    String insomniacNewRole = '';
    for (int i = 0; i < Game.people; i++) {
      if (Game.players[i].name == Game.whoIsInsomniac) {
        insomniacNewRole = Game.players[i].role;
      }
    }
    return SizedBox(
      width: wid,
      child: currentRole != 'Insomniac' || insomniacNewRole == ''
          ? LayoutBuilder(
              builder: (context, constraints) {
                var smallestBoundary =
                    min(constraints.maxHeight, constraints.maxWidth);
                return CircularWidgets(
                  startAngleDeg: startAngleDeg,
                  totalArchDeg: totalArchDeg,
                  isClockWise: isClockwise,
                  itemsLength: length,
                  itemBuilder: (context, index) {
                    // Can be any widget, preferably a circle
                    return showBackCard(Game.players[index], canOutBeSeen,
                        context, Game.players[index].isSelected);
                  },
                  innerSpacing: smallestBoundary / innerSpacingDivider,
                  radiusOfItem: smallestBoundary / radiusOfItemDivider,
                  centerWidgetRadius:
                      smallestBoundary / centerWidgetRadiusDivider,
                  centerWidgetBuilder: (context) {
                    return Container(
                      //decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: currentRole != 'TroubleMaker'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    showMiddleCard(
                                        0,
                                        midCanBeSeen,
                                        context,
                                        smallestBoundary /
                                            centerWidgetRadiusDivider),
                                    showMiddleCard(
                                        1,
                                        midCanBeSeen,
                                        context,
                                        smallestBoundary /
                                            centerWidgetRadiusDivider),
                                  ],
                                ),
                                Center(
                                  child: showMiddleCard(
                                      2,
                                      midCanBeSeen,
                                      context,
                                      smallestBoundary /
                                          centerWidgetRadiusDivider),
                                ),
                              ],
                            )
                          : SizedBox(
                              height: 100,
                              width: 100,
                              child: Center(
                                child: selected == 2
                                    ? ElevatedButton(
                                        onPressed: () {
                                          exchange(exchangedPlayers[0],
                                              exchangedPlayers[1]);
                                          String tm =
                                              getRoleName('TroubleMaker');
                                          NightActions.troublemakerDid =
                                              '$tm The TroubleMaker Changed ${exchangedPlayers[0].name}\'s Card with ${exchangedPlayers[1].name}\' Card';
                                          unselectAll();
                                          setState(() {
                                            currentRole = '';
                                          });
                                        },
                                        child: Text(
                                            'Tap to Change ${exchangedPlayers[0].name} with ${exchangedPlayers[1].name}'))
                                    : const Text(''),
                              ),
                            ),
                    );
                  },
                );
              },
            )
          : Center(
              child: GestureDetector(
                child: Container(
                  height: Dev.hei,
                  width: Dev.wid / 1.6,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$insomniacNewRole.jpg'),
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    currentRole = '';
                  });
                },
              ),
            ),
    );
  }

  Future<void> god() async {
    howMuch++;
    if (howMuch == 1) {
      await play('EveryOneSleeper');
      await play('CountDowN');
      for (String i in Game.rolesInOrder) {
        if (checkIfIn(Game.listRoles, i)) {
          currentRole = i;
          if (i == 'Werewolf' && Game.roles['Werewolf'] == 2) {
            await play('WerewolvesWaker');
            await countDown(t: Settings.werewolfTime.toInt());
            setState(() {
              goToNextRole();
            });
            await play('WerewolfSleeper');
          } else if (i == 'Minion') {
            await play('MinionWaker');
            await countDown(t: Settings.minionTime.toInt());
            setState(() {
              goToNextRole();
            });
            await play('MinionSleeper');
          } else if (i == 'Seer') {
            setState(() {
              midCanBeSeen = true;
              midHowMuchCanBeSeen = 2;
              canOutBeSeen = true;
            });
            await play('SeerWaker'); //5 secs
            await countDown(t: Settings.seerTime.toInt());
            setState(() {
              midCanBeSeen = false;
              midHowMuchCanBeSeen = 0;
              canOutBeSeen = false;
              goToNextRole();
            });
            await play('SeerSleeper'); //4 secs
          } else if (i == 'Robber') {
            setState(() {
              canOutBeSeen = true;
            });
            await play('RobberWakeR');
            await countDown(t: Settings.robberTime.toInt());
            setState(() {
              canOutBeSeen = false;
              goToNextRole();
            });
            await play('RobberSleeper'); //2secs
          } else if (i == 'TroubleMaker') {
            await play('TroubleMakerWaker'); //6secs
            await countDown(t: Settings.troublemakerTime.toInt());
            unselectAll();
            if (mounted) {
              setState(() {
                goToNextRole();
              });
            }
            await play('TroubleMakerSleeper');
          } else if (i == 'Drunk') {
            await play('DrunkWaker');
            setState(() {
              haveDrunkExchanged = false;
            });
            await countDown(t: Settings.drunkTime.toInt());
            setState(() {
              goToNextRole();
            });
            await play('DrunkSleeper');
          } else if (i == 'Insomniac') {
            await play('InsomniacWaker');
            setState(() {});
            await countDown(t: Settings.insomniacTime.toInt());
            setState(() {
              goToNextRole();
            });
            await play('InsomniacSleeper');
          }
        }
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Day()));
      await play('AllWaker');
    }
    printAll();
  }

  bool fill(Player p) {
    for (int i = 0; i < 2; i++) {
      if (exchangedPlayers[i].name == '') {
        exchangedPlayers[i] = p;
        return true;
      }
    }
    return false;
  }

  bool empty(Player p) {
    for (int i = 0; i < 2; i++) {
      if (exchangedPlayers[i].name == p.name) {
        exchangedPlayers[i] = Player('');
        return true;
      }
    }
    return false;
  }

  void exchange(Player p1, Player p2) {
    String s1 = p1.role;
    String s2 = p2.role;
    int idx1 = 0;
    int idx2 = 0;
    for (int i = 0; i < Game.players.length; i++) {
      if (Game.players[i].name == p1.name) {
        idx1 = i;
      } else if (Game.players[i].name == p2.name) {
        idx2 = i;
      }
    }
    Game.players[idx1].role = s2;
    Game.players[idx2].role = s1;
    //Game.nightActions.add(
    //   '${Game.firstRoles['TroubleMaker']}the TroubleMaker changed ${p1.name}\' Card with ${p2.name}\' Card');
  }

  void unselectAll() {
    for (int i = 0; i < Game.players.length; i++) {
      Game.players[i].isSelected = false;
    }
    timeLeft = 0;
  }

  Future play(dir) async {
    await player.setAsset('assets/sounds/$dir.mp3');
    await player.play();
    await player.pause();
  }

  bool checkIfIn(List<String> lst, String item) {
    for (String i in lst) {
      if (item == i) {
        return true;
      }
    }
    return false;
  }

  Future countDown({int t = 10}) async {
    timeLeft = t;
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (timeLeft % 2 == 0 && mounted) {
        setState(() {
          isRed = '';
        });
      } else if (mounted && timeLeft <= 5) {
        setState(() {
          isRed = 'Red';
        });
      }
      if (timeLeft <= 0) timer.cancel();
      timeLeft--;
    });
    await Future.delayed(Duration(seconds: t), () {});
  }

  void goToNextRole() {
    if (dialogIsClosed == false) Navigator.pop(dialogContext);
    currentRole = '';
  }

  String getRoleName(String role) {
    for (int i = 0; i < Game.people; i++) {
      if (Game.firstPlayers[i].role == role) {
        return Game.firstPlayers[i].name;
      }
    }
    return '';
  }
}
