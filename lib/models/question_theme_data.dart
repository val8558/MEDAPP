class QuestionThemeData {
  final Map data;
  final String id;

  QuestionThemeData(this.id, this.data){
    if(data['games'] != null && data['games'] is! List<String>){
      data['games'] = List<String>.from(data['games']).map((theme) {
        switch (theme) {
          case 'infinite':
            return TypeGame.infinite;
          case 'run':
            return TypeGame.run;
          case 'flash':
            return TypeGame.flash;
          default:
            return TypeGame.normal;
        }
      }).toList();
    }
  }

  String get type => data['type'] ?? '';
  String get img => data['img'] ?? '';
  String get title => data['title'] ?? '';
  String get subTitle => data['sub_title'] ?? '';
  List<TypeGame> get games => data['games'] ?? [];
}

enum TypeGame {
  normal,
  infinite,
  run,
  flash,
}