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
      this.contentHeightRatio = 0.4,
      this.icon})
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
  Widget content;
  bool isLast;
  double contentHeightRatio;
  Widget icon;

  Widget _drawIndicator(double screenWidth, double screenHeight) {
    return Expanded(
      flex: 1,
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          SizedBox(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            child: Indicator(
              color: color,
              icon: icon,
            ),
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
                      radiusWidthRatio: contentHeightRatio),
                ),
              ),
              // Expanded(
              //   child: CustomPaint(
              //     painter: Connector(color: color, direction: middle),
              //   ),
              // ),
              Expanded(
                child: CustomPaint(
                  painter: Connector(
                      color: color,
                      direction: before,
                      isLast: isLast,
                      radiusWidthRatio: contentHeightRatio),
                ),
              ),
            ],
          ),
          Row(
            children: [
              arcDirection == ArcDirection.right
                  ? _drawContent()
                  : _drawIndicator(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
              arcDirection == ArcDirection.right
                  ? _drawIndicator(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height)
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
