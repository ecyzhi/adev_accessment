class Level {
  int id;
  String levelName;
  String levelContent;

  Level({this.id, this.levelName, this.levelContent});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['levelName'] = levelName;
    m['levelContent'] = levelContent;

    return m;
  }
}
