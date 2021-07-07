import 'package:adev_accessment/timeline/tile.dart';
import 'package:flutter/material.dart';

enum StartDirection { left, right }

class TileRepeater extends StatelessWidget {
  TileRepeater(
      {key,
      this.noOfLevel = 5,
      this.archievedLevel = 1,
      this.startDirection = StartDirection.right})
      : super(key: key);
  int noOfLevel;
  int archievedLevel;
  StartDirection startDirection;

  ArcDirection _getArcDirection(int i) {
    if (startDirection == StartDirection.right) {
      if (i % 2 == 0)
        return ArcDirection.left;
      else
        return ArcDirection.right;
    } else {
      if (i % 2 == 0)
        return ArcDirection.right;
      else
        return ArcDirection.left;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            for (int i = noOfLevel; i > 0; i--)
              Tile(
                arcDirection: _getArcDirection(i),
                color: i <= archievedLevel ? Colors.yellow : Colors.white,
                content: Text('Level $i'),
              ),
          ],
        ),
      ),
    );
  }
}