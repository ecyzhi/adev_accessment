class Level {
  int id;
  String levelName;
  static int noOfLevel = 9;

  static List<String> level =
      List<String>.generate(noOfLevel, (index) => 'Level ${index + 1}');

  static Map<String, int> levelMap = generateLevelMap();

  Level({this.id, this.levelName});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['levelName'] = levelName;

    return m;
  }

  static Map<String, int> generateLevelMap() {
    Map<String, int> generatedMap = {};
    for (int i = 0; i < noOfLevel; i++) {
      generatedMap['Level ${i + 1}'] = i;
    }
    return generatedMap;
  }
}
