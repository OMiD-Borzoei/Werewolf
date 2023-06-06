import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

import 'package:werewolf/screens/vote.dart';
import 'package:werewolf/shared/settings.dart';
import 'package:just_audio/just_audio.dart';

class Day extends StatefulWidget {
  const Day({Key? key}) : super(key: key);

  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> with SingleTickerProviderStateMixin {

  Timer? countdownTimer;
  Duration myDuration = Duration(minutes: Settings.voteTime.toInt());
  double secs = Settings.voteTime*60;

  Color inner = Colors.black87;
  Color outer = Colors.black87;

  @override
  void initState() {
    super.initState();
    startTimer();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  /// Timer related methods ///
  // Step 3
  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(milliseconds: 100), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 100;
    if (mounted) {
      setState(() {
        final seconds = myDuration.inMilliseconds - reduceSecondsBy;
        int s = seconds~/1000;
        if (s <= 5 && s>=0){
          if(s % 2 == 1){
            outer = Colors.red.shade800;
            inner = Colors.black87;
          }
          else {
            inner = Colors.red.shade600;
            outer = Colors.black87;
          }
        }
        if (seconds < 0) {
          countdownTimer!.cancel();
          inner = outer;
          var player = AudioPlayer();
          player.setAsset('assets/sounds/Notifs/Howl.mp3');
          player.play();

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const Vote()));
        } else {
          myDuration = Duration(milliseconds: seconds);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    final mili = strDigits(myDuration.inMilliseconds.remainder(60000));
    final intMin = int.parse(minutes);
    final intMil = int.parse(mili);
    return WillPopScope(
      child: Container(
        color: Colors.white,
        child: Container(
          color: Colors.black87,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
            child: Stack(children: [
              Center(
                child: Container(
                  height: 325,
                  width: 325,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 325,
                  width: 325,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff333333),
                  ),
                ),
              ),
              Center(
                child: CustomPaint(
                  size: const Size(300, 300),
                  painter: CustomCircle(
                      const Color(0xfffaa1fc), ((intMin * 60 + intMil/1000) / secs) * 2 * math.pi),
                ),
              ),
              Center(
                child: Container(
                  height: 278,
                  width: 278,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 278,
                  width: 278,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: inner,
                  ),
                ),
              ),
              Center(
                child: Text(
                  '$minutes:$seconds',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                      decoration: TextDecoration.none),
                ),
              ),
              Container(
                //alignment: Alignment.bottomRight,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  //foregroundColor: MyTheme.primary,
                  icon: const Icon(
                    Icons.warning_amber_outlined,
                  ),
                  label: const Text(
                    'Vote Now',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),

                  onPressed: () {
                    setState(() {
                      myDuration=const Duration(seconds: 0);
                    });
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
      onWillPop: (){
        return Future.value(false);
      },
    );
  }
}

class CustomCircle extends CustomPainter {
  double right = 300;
  double bottom = 300;
  Color color;
  double rad;

  CustomCircle(this.color, this.rad);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0, 0, right, bottom);
    const startAngle = 3 * math.pi / 2;
    final sweepAngle = rad;
    const useCenter = false;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;
    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
