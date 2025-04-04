class QuestionData{
  final Map data;

  QuestionData(this.data){
    if(data['answers'] != null && data['answers'] is! List<String>){
      data['answers'] = List<String>.from(data['answers']);
    }
    if(data['type'] != null && data['type'] is! List<String>){
      data['type'] = List<String>.from(data['type']);
    }
  }

  List<String> get answers => data['answers'] ?? [];
  int get correct => data['correct'] ?? -1;
  String get img => data['img'] ?? "";
  String get question => data['question'] ?? "Curso não encontrado";
  String get theme => data['theme'] ?? "";
  List<String> get type => data['type'] ?? [];
}