import 'package:flutter/material.dart';

class ProgressPainter extends CustomPainter {
  int noOfLevel;
  int progressLevel;
  bool isDefaultPath;
  ProgressPainter(
      {this.noOfLevel, this.progressLevel, this.isDefaultPath = false});

  @override
  void paint(Canvas canvas, Size size) {
    Color pathColor = isDefaultPath ? Colors.white : Colors.yellow;

    final paint = Paint()
      ..color = pathColor
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    final shadowPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);

    final path = Path();

    path.moveTo(size.width * 1 / 2, size.height * noOfLevel / noOfLevel);

    var radius = size.width * 0.2;

    for (int i = 0; i < noOfLevel; i++) {
      if (i < progressLevel || isDefaultPath) {
        if (i % 2 == 0) {
          path.lineTo(
              size.width * 0.7, size.height * (noOfLevel - i) / noOfLevel);
          path.arcToPoint(
              Offset(size.width * 0.7,
                  size.height * (noOfLevel - i - 1) / noOfLevel),
              radius: Radius.circular(radius),
              clockwise: false);
          path.lineTo(
              size.width * 0.5, size.height * (noOfLevel - i - 1) / noOfLevel);
        } else {
          path.lineTo(
              size.width * 0.3, size.height * (noOfLevel - i) / noOfLevel);
          path.arcToPoint(
              Offset(size.width * 0.3,
                  size.height * (noOfLevel - i - 1) / noOfLevel),
              radius: Radius.circular(radius),
              clockwise: true);
          path.lineTo(
              size.width * 0.5, size.height * (noOfLevel - i - 1) / noOfLevel);
        }
      }
    }
    canvas.drawPath(path.shift(Offset(0, 5)), shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
