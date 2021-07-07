import 'package:adev_accessment/timeline/connector.dart';
import 'package:adev_accessment/timeline/indicator.dart';
import 'package:flutter/material.dart';

enum ArcDirection { left, right }

class Tile extends StatelessWidget {
  Tile(
      {key,
      this.arcDirection = ArcDirection.left,
      this.color = Colors.white,
      this.content})
      : super(key: key) {
    this.before = arcDirection == ArcDirection.right
        ? Direction.right_before
        : Direction.left_before;
    this.after = arcDirection == ArcDirection.right
        ? Direction.right_after
        : Direction.left_after;
    this.color = color;
    this.content = content;
  }

  ArcDirection arcDirection;
  Direction before;
  Direction after;
  Color color;
  Widget content = Text('Hey');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CustomPaint(
                  painter: Connector(color: color, direction: after),
                ),
              ),
              Expanded(
                child: CustomPaint(
                  painter: Connector(color: color, direction: before),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: Row(
                  children: [
                    arcDirection == ArcDirection.right
                        ? Expanded(
                            flex: 4,
                            child: Card(
                              child: Center(
                                child: content,
                              ),
                            ),
                          )
                        : Expanded(
                            flex: 1,
                            child: Indicator(),
                          ),
                    arcDirection == ArcDirection.right
                        ? Expanded(
                            flex: 1,
                            child: Indicator(),
                          )
                        : Expanded(
                            flex: 4,
                            child: Card(
                              child: Center(
                                child: content,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.45,
    );
  }
}
