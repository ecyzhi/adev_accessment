import 'package:adev_accessment/timeline/connector.dart';
import 'package:adev_accessment/timeline/indicator.dart';
import 'package:flutter/material.dart';

enum ArcDirection { left, right, middle }

class Tile extends StatelessWidget {
  Tile(
      {key,
      this.arcDirection = ArcDirection.left,
      this.color = Colors.white,
      this.content,
      this.isLast = false,
      this.contentHeightRatio = 0.4})
      : super(key: key) {
    this.before = arcDirection == ArcDirection.right
        ? Direction.right_before
        : Direction.left_before;
    this.after = arcDirection == ArcDirection.right
        ? Direction.right_after
        : Direction.left_after;
    this.middle = arcDirection == ArcDirection.right
        ? Direction.right_middle
        : Direction.left_middle;
  }

  ArcDirection arcDirection;
  Direction before;
  Direction after;
  Direction middle;
  Color color;
  Widget content = Text('Hey');
  bool isLast;
  double contentHeightRatio;

  Widget _drawIndicator() {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            child: Indicator(),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget _drawContent() {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: content,
      ),
    );
  }

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
                  painter: Connector(
                      color: color,
                      direction: after,
                      isLast: isLast,
                      radiusWidthRatio: contentHeightRatio / 2.0),
                ),
              ),
              Expanded(
                child: CustomPaint(
                  painter: Connector(color: color, direction: middle),
                ),
              ),
              Expanded(
                child: CustomPaint(
                  painter: Connector(
                      color: color,
                      direction: before,
                      isLast: isLast,
                      radiusWidthRatio: contentHeightRatio / 2.0),
                ),
              ),
            ],
          ),
          Row(
            children: [
              arcDirection == ArcDirection.right
                  ? _drawContent()
                  : _drawIndicator(),
              arcDirection == ArcDirection.right
                  ? _drawIndicator()
                  : _drawContent(),
            ],
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * contentHeightRatio,
    );
  }
}
