import 'package:flutter/material.dart';
import 'package:werewolf/screens/results.dart';
import 'package:werewolf/shared/game.dart';
import 'package:werewolf/shared/settings.dart';

class Vote extends StatefulWidget {
  const Vote({Key? key}) : super(key: key);

  @override
  _VoteState createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/Death.jpg'),
          fit: BoxFit.fill,
        )),
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            Container(
              child: makePlayerWidgets(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(onPressed: (){
                Game.executed = Player('');
                Game.whoHasWon();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Results()));
              },
                  child: const SizedBox(
                    //height: 50,
                    //width: 50,
                    child: Text('We Choose To Kill No One!'),
                  )),
            ),
          ],
        ),
      ),
      onWillPop: (){
        return Future.value(false);
      },
    );
  }

  Widget makePlayerWidgets() {
    Color c1 = Colors.blue.shade700;
    Color c2 = Colors.brown.shade900;
    return Column(
      children: [
        for (int i = 0;
            Game.people % 3 == 0
                ? i < Game.people ~/ 3
                : i < Game.people ~/ 3 + 1;
            i++)
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            for (int j = 1; (i) * 3 + j <= Game.people && j <= 3; j++)
                //color: i % 2 == 1 ? MyTheme.primary : MyTheme.secondary,
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    decoration: BoxDecoration(
                      color: i % 2 == 1
                          ? j == 2
                              ? c1
                              : c2
                          : j == 2
                              ? c2
                              : c1,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: Dev.hei * 0.11,
                    //Dev.hei * 0.15,
                    width: Dev.wid / 4.5,
                    //Dev.wid / 3.9,
                    child: Center(
                      child: Text(
                        Game.players[i * 3 + j - 1].name.toString(),
                        style: TextStyle(
                          color: i % 2 == 1
                              ? j == 2
                                  ? c2
                                  : c1
                              : j == 2
                                  ? c1
                                  : c2,
                          fontSize: 16,
                          decoration: TextDecoration.none
                        ),

                      ),
                    ),
                  ),
                  onTap: () {
                    Game.executed = Game.players[i * 3 + j - 1];
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'Are You Sure You Want To Execute ${Game.executed.name} ?',
                                    style: const TextStyle(fontSize: 15, color: Colors.blue, decoration: TextDecoration.none),),
                                  color: Colors.black,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          Game.whoHasWon();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => const Results()));
                                        }),
                                    ElevatedButton(
                                        child: const Text('No'),
                                        onPressed: () {
                                          Game.executed = Player('');
                                          Navigator.pop(context);
                                        })
                                  ],
                                )
                              ],
                          );
                        });
                    //printWinners();
                  },
                ),
          ]),
      ],
    );
  }
}
