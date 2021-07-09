import 'package:adev_accessment/timeline/tile.dart';
import 'package:flutter/material.dart';

enum StartDirection { left, right }

class TileRepeater extends StatelessWidget {
  TileRepeater(
      {key,
      this.noOfLevel = 5,
      this.achievedLevel = 1,
      this.startDirection = StartDirection.right,
      this.content,
      this.defaultColor = Colors.white,
      this.doneColor = Colors.yellow,
      this.contentHeightRatio = 0.4,
      this.icon})
      : super(key: key);
  int noOfLevel;
  int achievedLevel;
  StartDirection startDirection;
  List<Widget> content;
  Color defaultColor;
  Color doneColor;
  double contentHeightRatio;
  Widget icon;

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
                color: i <= achievedLevel ? doneColor : defaultColor,
                content: content[noOfLevel - i],
                isLast: i == noOfLevel,
                contentHeightRatio: contentHeightRatio,
                icon: icon,
              ),
          ],
        ),
      ),
    );
  }
}
