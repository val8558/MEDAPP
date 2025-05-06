class QuestionThemeData {
  final Map data;

  QuestionThemeData(this.data);

  String get type => data['type'] ?? '';
  String get img => data['img'] ?? '';
  String get title => data['title'] ?? '';
  String get subTitle => data['sub_title'] ?? '';
  List<dynamic> get games => data['games'] ?? [];
}