import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Homepage(),
));

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> level = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5',
  ];

  String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )
                    ),
                    items: level.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                    onChanged: (value){
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    hint: Text('Select Level'),
                  ),
                  Expanded(
                    child: Card(
                      child: Center(
                        child: Text(selectedValue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
