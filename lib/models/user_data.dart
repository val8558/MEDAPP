class UserData {
  static final UserData _instance = UserData._internal();

  // Campos da classe
  late String uid;
  late String name;
  late String user;
  late String email;
  late String ie;
  late String photo;

  // Construtor privado
  UserData._internal();

  // Factory para retornar a instância única
  factory UserData() {
    return _instance;
  }

  // Método para inicializar os dados do usuário
  void initialize({
    required String uid,
    required String name,
    required String user,
    required String email,
    required String ie,
    String photo = "",
  }) {
    this.uid = uid;
    this.name = name;
    this.user = user;
    this.email = email;
    this.ie = ie;
    this.photo = photo;
  }

  // Método para criar a instância a partir de um JSON
  void fromJson(String uid, Map<String, dynamic> json) {
    this.uid = uid;
    name = json['name'];
    user = json['user'];
    email = json['email'];
    ie = json['ie'];
    photo = json['photo'] ?? "";
  }
}