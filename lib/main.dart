import 'package:adev_accessment/timeline/connector.dart';
import 'package:adev_accessment/timeline/indicator.dart';
import 'package:adev_accessment/timeline/tile.dart';
import 'package:adev_accessment/timeline/tile_repeater.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:adev_accessment/level.dart';
import 'package:adev_accessment/progress_painter.dart';
import 'package:device_preview/device_preview.dart';

void main() => runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => MaterialApp(
          locale: DevicePreview.locale(context), // Add the locale here
          builder: DevicePreview.appBuilder, // Add the builder here
          home: Homepage(),
        ), // Wrap your app
      ),
    );

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  ScrollController _scrollController = ScrollController();
  final LocalStorage storage = LocalStorage('adev');
  Level currentLevel =
      Level(id: 0, levelName: 'Level 1', levelContent: 'Level 1 Content');
  bool initialized = false;

  int noOfLevel = 5;
  List<Level> levelList = [];

  void _initLevelList() {
    for (int i = 0; i < noOfLevel; i++) {
      levelList.add(new Level(
          id: i,
          levelName: 'Level ${i + 1}',
          levelContent: 'Level ${i + 1} Content'));
    }
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          );
        });
  }

  void _storeLevel() {
    setState(() {
      storage.setItem('adev_level', currentLevel.toJSONEncodable());
    });
  }

  void _getStoredLevel() {
    var storedValue = storage.getItem('adev_level');
    if (storedValue != null) {
      currentLevel.id = storedValue['id'];
      currentLevel.levelName = storedValue['levelName'];
      currentLevel.levelContent = storedValue['levelContent'];
      print(storedValue.toString() +
          ' | ' +
          currentLevel.id.toString() +
          ' | ' +
          currentLevel.levelName +
          ' | ' +
          currentLevel.levelContent);
    }
  }

  Widget _drawProgressPath(int progressLevel) {
    return CustomPaint(
      painter: ProgressPainter(
          noOfLevel: noOfLevel, progressLevel: 0, isDefaultPath: true),
      foregroundPainter:
          ProgressPainter(noOfLevel: noOfLevel, progressLevel: progressLevel),
    );
  }

  Widget _drawButtonContentLayout() {
    return Column(
      children: <Widget>[
        for (int i = noOfLevel; i > 0; i--)
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: i % 2 == 0
                        ? FractionallySizedBox(
                            widthFactor: 0.7,
                            heightFactor: 0.7,
                            child: ElevatedButton(
                                child: Image.asset(
                                    'assets/images/vimigo_logo_mini.png'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.yellow,
                                  shape: CircleBorder(),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _showBottomSheet();
                                  });
                                }),
                          )
                        : Center(
                            child: Padding(
                            padding: EdgeInsets.all(25),
                            child: Card(
                                color: Colors.white,
                                elevation: 2,
                                child: Center(
                                    child:
                                        Text(levelList[i - 1].levelContent))),
                          )),
                  ),
                  flex: i % 2 == 0 ? 1 : 4,
                ),
                Expanded(
                  child: Container(
                      child: i % 2 == 0
                          ? Center(
                              child: Padding(
                              padding: EdgeInsets.all(25),
                              child: Card(
                                  color: Colors.white,
                                  elevation: 2,
                                  child: Center(
                                      child:
                                          Text(levelList[i - 1].levelContent))),
                            ))
                          : FractionallySizedBox(
                              widthFactor: 0.7,
                              heightFactor: 0.7,
                              child: ElevatedButton(
                                  child: Image.asset(
                                      'assets/images/vimigo_logo_mini.png'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.yellow,
                                    shape: CircleBorder(),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showBottomSheet();
                                    });
                                  }),
                            )),
                  flex: i % 2 == 0 ? 4 : 1,
                ),
              ],
            ),
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _initLevelList();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
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
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!initialized) {
              _getStoredLevel();
              initialized = true;
            }

            return Column(
              children: [
                // Expanded(
                //   child: Container(
                //     color: Colors.blue,
                //     padding: EdgeInsets.all(20),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.stretch,
                //       children: [
                //         Container(
                //           padding:
                //               EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                //           decoration: BoxDecoration(
                //               color: Colors.white,
                //               borderRadius: BorderRadius.circular(15)),
                //           child: DropdownButton<String>(
                //             items: levelList
                //                 .map((Level list) => DropdownMenuItem(
                //                     value: list.levelName,
                //                     child: Text(list.levelName)))
                //                 .toList(),
                //             onChanged: (value) {
                //               setState(() {
                //                 currentLevel.levelName = value;
                //                 currentLevel.id = levelList
                //                     .where(
                //                         (element) => value == element.levelName)
                //                     .first
                //                     .id;
                //                 currentLevel.levelContent = levelList
                //                     .where(
                //                         (element) => value == element.levelName)
                //                     .first
                //                     .levelContent;
                //                 _storeLevel();
                //               });
                //             },
                //             value: currentLevel.levelName,
                //             icon: Icon(Icons.expand_more),
                //             iconEnabledColor: Colors.blue,
                //             iconSize: 40,
                //             isExpanded: true,
                //           ),
                //         ),
                //         Expanded(
                //           child: Card(
                //             color: Colors.blue,
                //             child: Center(
                //               child: Text(
                //                 currentLevel.levelName,
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _scrollController,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          child: _drawProgressPath(currentLevel.id + 1),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width *
                              noOfLevel *
                              0.4,
                        ),
                        Container(
                          child: _drawButtonContentLayout(),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width *
                              noOfLevel *
                              0.4,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TileRepeater(
                      noOfLevel: noOfLevel,
                      achievedLevel: currentLevel.id + 1,
                      startDirection: StartDirection.left,
                      defaultColor: Colors.white,
                      doneColor: Colors.yellow,
                      //TODO: How to check whether the contentlist.length is same with noOfLevel else throw error
                      content: [
                        for (int i = noOfLevel; i > 0; i--)
                          Card(
                            child: Center(
                              child: Text('Level $i'),
                            ),
                          ),
                      ],
                    ),
                    // child: SingleChildScrollView(
                    //   child: Column(
                    //     children: [
                    //       Tile(
                    //         arcDirection: ArcDirection.right,
                    //         color: Colors.white,
                    //         content: Card(
                    //           child: Center(
                    //             child: Text('red'),
                    //           ),
                    //         ),
                    //         isLast: true,
                    //       ),
                    //       Tile(
                    //         arcDirection: ArcDirection.left,
                    //         color: Colors.yellow,
                    //         content: Text(
                    //             '123\n456\n789\n123\n456\nqwertyuiop\nasdfghjklasdasasdasdasdasdasdasd\nzxcvbnmasdfqwerasdqweasdqweasdqwe'),
                    //       ),
                    //       Tile(
                    //         arcDirection: ArcDirection.right,
                    //         color: Colors.yellow,
                    //         content: Text('red'),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    color: Colors.green[100],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
