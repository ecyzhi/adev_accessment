import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  int noOfLevel = 5;
  int progressLevel;
  bool isDefaultPath;
  ProgressPainter({this.progressLevel, this.isDefaultPath = false});

  @override
  void paint(Canvas canvas, Size size) {
    Color pathColor = isDefaultPath ? Colors.white : Colors.yellow;

    final paint = Paint()
      ..color = pathColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final path = Path();

    path.moveTo(size.width * 1 / 2, size.height * noOfLevel / noOfLevel);

    for (int i = 0; i < (noOfLevel + 1); i++) {
      if (i <= progressLevel || isDefaultPath) {
        path.arcToPoint(
            Offset(
                size.width * 1 / 2, size.height * (noOfLevel - i) / noOfLevel),
            radius:
            Radius.elliptical(size.width * 4 / 10, size.height * 1 / 10),
            clockwise: (i % 2 == 0));
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}