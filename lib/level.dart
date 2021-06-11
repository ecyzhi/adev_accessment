class Level{
  int id;
  String levelName;

  Level({this.id, this.levelName});

  static Map<String, int> levelMap = {
    'Level 1': 0,
    'Level 2': 1,
    'Level 3': 2,
    'Level 4': 3,
    'Level 5': 4,
  };

  static List<String> level = [
    'Level 1',
    'Level 2',
    'Level 3',
    'Level 4',
    'Level 5',
  ];

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['levelName'] = levelName;

    return m;
  }
}