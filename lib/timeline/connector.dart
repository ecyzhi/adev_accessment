import 'package:flutter/material.dart';

enum Direction { left_before, left_after, right_before, right_after }

class Connector extends CustomPainter {
  Color color;
  Direction direction;
  int noOfMaxLevel;
  int noOfCurrentLevel;

  Connector({this.color, this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final shadowPaint = Paint()
      ..color = Colors.grey.shade600
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5);

    final path = Path();
    var radius = size.width * 0.2;

    if (direction == Direction.right_before) {
      path.moveTo(size.width * 0.5, size.height);
      path.lineTo(size.width * 0.7, size.height);
      path.arcToPoint(Offset(size.width * 0.9, 0),
          radius: Radius.circular(radius), clockwise: false);
    } else if (direction == Direction.right_after) {
      path.moveTo(size.width * 0.9, size.height);
      path.arcToPoint(Offset(size.width * 0.7, 0),
          radius: Radius.circular(radius), clockwise: false);
      path.lineTo(size.width * 0.5, 0);
    } else if (direction == Direction.left_before) {
      path.moveTo(size.width * 0.5, size.height);
      path.lineTo(size.width * 0.3, size.height);
      path.arcToPoint(Offset(size.width * 0.1, 0),
          radius: Radius.circular(radius), clockwise: true);
    } else if (direction == Direction.left_after) {
      path.moveTo(size.width * 0.1, size.height);
      path.arcToPoint(Offset(size.width * 0.3, 0),
          radius: Radius.circular(radius), clockwise: true);
      path.lineTo(size.width * 0.5, 0);
    }

    canvas.drawPath(path.shift(Offset(0, 7)), shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
