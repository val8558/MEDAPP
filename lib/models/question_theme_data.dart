class QuestionThemeData {
  final Map data;

  QuestionThemeData(this.data);

  String get img => data['img'] ?? "";
  String get title => data['title'] ?? "Theme";
}