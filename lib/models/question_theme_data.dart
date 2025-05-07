class QuestionThemeData {
  final Map data;
  final String id;

  QuestionThemeData(this.id, this.data){
    if(data['games'] != null && data['games'] is! List<String>){
      data['games'] = List<String>.from(data['games']).map((theme) {
        switch (theme) {
          case 'infinite':
        return TypeGames.infinite;
          case 'run':
        return TypeGames.run;
          case 'flash':
        return TypeGames.flash;
          default:
        throw ArgumentError('Invalid theme value: $theme');
        }
      }).toList();
    }
  }

  String get type => data['type'] ?? '';
  String get img => data['img'] ?? '';
  String get title => data['title'] ?? '';
  String get subTitle => data['sub_title'] ?? '';
  List<TypeGames> get games => data['games'] ?? [];
}

enum TypeGames {
  infinite,
  run,
  flash,
}