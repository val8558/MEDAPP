class QuestionData{
  final String id;
  final Map data;

  QuestionData(this.id, this.data){
    if(data['answers'] != null && data['answers'] is! List<String>){
      data['answers'] = List<String>.from(data['answers']);
    }
    if(data['theme'] != null && data['theme'] is! List<String>){
      data['theme'] = List<String>.from(data['theme']);
    }
  }

  List<String> get answers => data['answers'] ?? [];
  int get correct => data['correct'] ?? -1;
  String get img => data['img'] ?? "";
  String get question => data['question'] ?? "Curso não encontrado";
  List<String> get theme => data['theme'] ?? [];
}