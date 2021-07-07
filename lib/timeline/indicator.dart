import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Image.asset('assets/images/vimigo_logo_mini.png'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        primary: Colors.yellow,
        shape: CircleBorder(),
      ),
      onPressed: () {},
    );
  }
}
