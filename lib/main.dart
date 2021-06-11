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
  ScrollController _scrollController = ScrollController();

  Map<String, int> levelMap = {
    'Level 1': 0,
    'Level 2': 1,
    'Level 3': 2,
    'Level 4': 3,
    'Level 5': 4,
  };

  List<String> level = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5',
  ];

  String selectedValue = 'Level 1';

  int currentStep = 0;

  List<Step> steps = [
    Step(
      title: Text('Level 1'),
      content: Text('Level 1'),
      isActive: true,
    ),
    Step(
      title: Text('Level 2'),
      content: Text('Level 2'),
      isActive: true,
    ),
    Step(
      title: Text('Level 3'),
      content: Text('Level 3'),
      isActive: true,
    ),
    Step(
      title: Text('Level 4'),
      content: Text('Level 4'),
      isActive: true,
    ),
    Step(
      title: Text('Level 5'),
      content: Text('Level 5'),
      isActive: true,
    ),
  ];

  void _showBottomSheet(){
    showModalBottomSheet(context: context, builder: (context){
      return ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: (){
          Navigator.pop(context);
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _showBottomSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton<String>(
                      items: level.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
                      onChanged: (value){
                        setState(() {
                          selectedValue = value;
                          currentStep = levelMap[selectedValue];
                        });
                      },
                      value: selectedValue,
                      icon: Icon(Icons.expand_more),
                      iconEnabledColor: Colors.blue,
                      iconSize: 40,
                      isExpanded: true,
                    ),
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          selectedValue,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              child: Container(
                child: Stepper(
                  physics: ClampingScrollPhysics(),
                  steps: steps,
                  currentStep: currentStep,
                  type: StepperType.vertical,
                  onStepTapped: (step) {
                    setState(() {
                      currentStep = step;
                      _showBottomSheet();
                    });
                  },
                  controlsBuilder: (context, {onStepContinue, onStepCancel}){
                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

