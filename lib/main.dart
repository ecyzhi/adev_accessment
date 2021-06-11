import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:adev_accessment/level.dart';

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
  final LocalStorage storage = LocalStorage('adev');

  Level currentLevel = Level(id: 0, levelName: 'Level 1');
  bool initialized = false;

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

  void _storeLevel(){
    setState(() {
      storage.setItem('adev_level', currentLevel.toJSONEncodable());
    });
  }

  void _getStoredLevel() {
    var storedValue = storage.getItem('adev_level');
    if(storedValue != null){
      currentLevel.id = storedValue['id'];
      currentLevel.levelName = storedValue['levelName'];
      print(storedValue.toString() + ' | ' + currentLevel.id.toString() + ' | ' + currentLevel.levelName);
    }
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
      body: FutureBuilder(
        future: storage.ready,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.data == null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(!initialized) {
            _getStoredLevel();
            initialized = true;
          }

          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<String>(
                          items: Level.level.map((String value) =>
                              DropdownMenuItem(
                                  value: value, child: Text(value))).toList(),
                          onChanged: (value) {
                            setState(() {
                              currentLevel.levelName = value;
                              currentLevel.id = Level.levelMap[currentLevel.levelName];
                              _storeLevel();
                            });
                          },
                          value: currentLevel.levelName,
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
                              currentLevel.levelName,
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
                      currentStep: currentLevel.id,
                      type: StepperType.vertical,
                      onStepTapped: (step) {
                        setState(() {
                          currentLevel.id = step;
                          _showBottomSheet();
                        });
                      },
                      controlsBuilder: (context,
                          {onStepContinue, onStepCancel}) {
                        return Container();
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

