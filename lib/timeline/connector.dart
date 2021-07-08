import 'package:flutter/material.dart';

enum Direction {
  left_before,
  left_after,
  left_middle,
  right_before,
  right_after,
  right_middle
}

class Connector extends CustomPainter {
  Color color;
  Direction direction;
  bool isLast;
  double radiusWidthRatio;

  Connector(
      {this.color,
      this.direction,
      this.isLast = false,
      this.radiusWidthRatio = 0.2});

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
    var radius = size.width * radiusWidthRatio;

    if (direction == Direction.right_before) {
      path.moveTo(size.width * 0.5, size.height);
      path.lineTo(size.width * 0.7, size.height);
      path.arcToPoint(Offset(size.width * 0.9, 0),
          radius: Radius.circular(radius), clockwise: false);
    } else if (direction == Direction.right_after) {
      path.moveTo(size.width * 0.9, size.height);
      path.arcToPoint(Offset(size.width * 0.7, 0),
          radius: Radius.circular(radius), clockwise: false);
      if (isLast) {
        path.lineTo(size.width * 0.3, 0);
      } else {
        path.lineTo(size.width * 0.5, 0);
      }
    } else if (direction == Direction.left_before) {
      path.moveTo(size.width * 0.5, size.height);
      path.lineTo(size.width * 0.3, size.height);
      path.arcToPoint(Offset(size.width * 0.1, 0),
          radius: Radius.circular(radius), clockwise: true);
    } else if (direction == Direction.left_after) {
      path.moveTo(size.width * 0.1, size.height);
      path.arcToPoint(Offset(size.width * 0.3, 0),
          radius: Radius.circular(radius), clockwise: true);
      if (isLast) {
        path.lineTo(size.width * 0.7, 0);
      } else {
        path.lineTo(size.width * 0.5, 0);
      }
    } else if (direction == Direction.left_middle) {
      path.moveTo(size.width * 0.1, size.height);
      path.lineTo(size.width * 0.1, 0);
    } else if (direction == Direction.right_middle) {
      path.moveTo(size.width * 0.9, size.height);
      path.lineTo(size.width * 0.9, 0);
    }

    canvas.drawPath(path.shift(Offset(0, 7)), shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
