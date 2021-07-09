import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  Indicator({key, this.color = Colors.yellow, this.icon}) : super(key: key);
  Color color;
  Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: icon ?? Container(),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        primary: color,
        shape: CircleBorder(),
        elevation: 5,
      ),
      onPressed: () {},
    );
  }
}
