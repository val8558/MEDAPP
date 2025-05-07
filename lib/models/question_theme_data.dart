class QuestionThemeData {
  final Map data;
  final String id;

  QuestionThemeData(this.id, this.data){
    if(data['games'] != null && data['games'] is! List<String>){
      data['games'] = List<String>.from(data['games']);
    }
  }

  String get type => data['type'] ?? '';
  String get img => data['img'] ?? '';
  String get title => data['title'] ?? '';
  String get subTitle => data['sub_title'] ?? '';
  List<String> get games => data['games'] ?? [];
}