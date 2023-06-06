import 'package:flutter/material.dart';
import 'package:werewolf/shared/settings.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){
    var paint = Paint();
    paint.color = MyTheme.secondary;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2.0;

    var path = Path();
    path.moveTo(size.width/1.3, size.height/8-size.width/8);
    path.lineTo(size.width/2.5, (size.height-size.width)/8);

    path.moveTo(size.width/1.4, (size.height+size.width)/8);
    path.lineTo(size.width/2.5, (size.height-size.width)/8);

    Offset center = Offset(size.width/1.3, size.height/8);
    canvas.drawCircle(center, size.width/8, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}