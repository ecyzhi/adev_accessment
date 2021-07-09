import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  Indicator({key, this.color = Colors.yellow}) : super(key: key);
  Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Image.asset('assets/images/vimigo_logo_mini.png'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        primary: color,
        shape: CircleBorder(),
      ),
      onPressed: () {},
    );
  }
}
