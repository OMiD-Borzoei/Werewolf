import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:werewolf/main.dart';
import 'package:werewolf/shared/settings.dart';

class SetTings extends StatefulWidget {
  const SetTings({Key? key}) : super(key: key);

  @override
  _SetTingsState createState() => _SetTingsState();
}

class _SetTingsState extends State<SetTings> {
  Color acColor = Colors.white;
  Color inColor = Colors.grey;
  Color alert = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        height: Dev.hei,
        width: Dev.wid,
        color: Colors.black87,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Wake up Times\n',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                ),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                    'Werewolves',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                title: Slider(
                    activeColor: Settings.werewolfTime > 5 ? acColor : alert,
                    inactiveColor: inColor,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label:
                        Settings.werewolfTime.toStringAsFixed(0) + ' seconds',
                    value: Settings.werewolfTime,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.werewolfTime = newVal;
                        MyApp.setSettings('werewolfTime', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.werewolfTime.toStringAsFixed(0),style: const TextStyle(color: Colors.purpleAccent),),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                      'Minion',
                      style: TextStyle(color: Colors.purpleAccent),
                ),
                ),
                title: Slider(
                    activeColor: Settings.minionTime > 5 ? acColor : alert,
                    inactiveColor: inColor,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label:
                    Settings.minionTime.toStringAsFixed(0) + ' seconds',
                    value: Settings.minionTime,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.minionTime = newVal;
                        MyApp.setSettings('minionTime', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.minionTime.toStringAsFixed(0),style: const TextStyle(color: Colors.purpleAccent),),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                    'Seer',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                title: Slider(
                    activeColor: Settings.seerTime > 10 ? acColor : alert,
                    inactiveColor: inColor,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label:
                    Settings.seerTime.toStringAsFixed(0) + ' seconds',
                    value: Settings.seerTime,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.seerTime = newVal;
                        MyApp.setSettings('seerTime', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.seerTime.toStringAsFixed(0),style: const TextStyle(color: Colors.purpleAccent),),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                    'Robber',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                title: Slider(
                    activeColor: Settings.robberTime > 8 ? acColor : alert,
                    inactiveColor: inColor,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label:
                    Settings.robberTime.toStringAsFixed(0) + ' seconds',
                    value: Settings.robberTime,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.robberTime = newVal;
                        MyApp.setSettings('robberTime', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.robberTime.toStringAsFixed(0),style: const TextStyle(color: Colors.purpleAccent),),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                    'TroubleMaker',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                title: Slider(
                    activeColor: Settings.troublemakerTime > 10 ? acColor : alert,
                    inactiveColor: inColor,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label:
                    Settings.troublemakerTime.toStringAsFixed(0) + ' seconds',
                    value: Settings.troublemakerTime,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.troublemakerTime = newVal;
                        MyApp.setSettings('troublemakerTime', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.troublemakerTime.toStringAsFixed(0),style: const TextStyle(color: Colors.purpleAccent),),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                    'Drunk',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                title: Slider(
                    activeColor: Settings.drunkTime > 7 ? acColor : alert,
                    inactiveColor: inColor,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label:
                    Settings.drunkTime.toStringAsFixed(0) + ' seconds',
                    value: Settings.drunkTime,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.drunkTime = newVal;
                        MyApp.setSettings('drunkTime', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.drunkTime.toStringAsFixed(0),style: const TextStyle(color: Colors.purpleAccent),),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                    'Insomniac',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                title: Slider(
                    activeColor: Settings.insomniacTime > 5 ? acColor : alert,
                    inactiveColor: inColor,
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label:
                    Settings.insomniacTime.toStringAsFixed(0) + ' seconds',
                    value: Settings.insomniacTime,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.insomniacTime = newVal;
                        MyApp.setSettings('insomniacTime', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.insomniacTime.toStringAsFixed(0),style: const TextStyle(color: Colors.purpleAccent),),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                    'All',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                title: Slider(
                    activeColor: allTheSame() ? Colors.green : Colors.grey.withOpacity(0.1),
                    inactiveColor: allTheSame() ? Colors.greenAccent : Colors.grey.withOpacity(0.1),
                    min: 0,
                    max: 30,
                    divisions: 30,
                    label:
                    Settings.all.toStringAsFixed(0) + ' seconds',
                    value: Settings.all,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.drunkTime = newVal;
                        Settings.troublemakerTime = newVal;
                        Settings.robberTime = newVal;
                        Settings.seerTime = newVal;
                        Settings.minionTime = newVal;
                        Settings.werewolfTime = newVal;
                        Settings.insomniacTime = newVal;
                        Settings.all = newVal;
                        MyApp.setSettings('insomniacTime', newVal.toInt());
                        MyApp.setSettings('drunkTime', newVal.toInt());
                        MyApp.setSettings('troublemakerTime', newVal.toInt());
                        MyApp.setSettings('robberTime', newVal.toInt());
                        MyApp.setSettings('seerTime', newVal.toInt());
                        MyApp.setSettings('minionTime', newVal.toInt());
                        MyApp.setSettings('werewolfTime', newVal.toInt());
                        MyApp.setSettings('all', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.all.toStringAsFixed(0),style: TextStyle(color: allTheSame() ? Colors.purpleAccent : Colors.purpleAccent.withOpacity(0.1)),),
              ),
              const Divider(
                color: Colors.white,
              ),
              const Center(
                child: Text(
                  'Others\n',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                ),
              ),
              ListTile(
                leading: SizedBox(
                  width: Dev.wid/4.5,
                  child: const Text(
                    'Day Vote Time',
                    style: TextStyle(color: Colors.purpleAccent),
                  ),
                ),
                title: Slider(
                    activeColor: acColor,
                    inactiveColor: inColor,
                    min: 2,
                    max: 10,
                    divisions: 8,
                    label:
                    Settings.voteTime.toStringAsFixed(0) + ' minutes',
                    value: Settings.voteTime,
                    onChanged: (newVal) {
                      setState(() {
                        Settings.voteTime = newVal;
                        MyApp.setSettings('voteTime', newVal.toInt());
                      });
                    }),
                trailing: Text(Settings.voteTime.toStringAsFixed(0),style: const TextStyle(color: Colors.purpleAccent),),
              ),
              
            ],
          ),
        ),
      ),
    );
  }

  bool allTheSame(){
    return Settings.werewolfTime == Settings.minionTime &&
          Settings.minionTime == Settings.seerTime &&
          Settings.seerTime == Settings.robberTime &&
          Settings.robberTime == Settings.troublemakerTime &&
          Settings.troublemakerTime == Settings.drunkTime &&
          Settings.drunkTime == Settings.insomniacTime;
  }


}
