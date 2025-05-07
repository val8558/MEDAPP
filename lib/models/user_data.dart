class UserData {
  static final UserData _instance = UserData._internal();

  bool initialized = false;

  late String uid;
  late String name;
  late String user;
  late String email;
  late String ie;
  late String photo;

  UserData._internal();

  factory UserData() {
    return _instance;
  }

  bool hasInitialized(){
    return initialized;
  }

  void initialize({
    required String uid,
    required String name,
    required String user,
    required String email,
    required String ie,
    String photo = "",
  }) {
    initialized = true;
    this.uid = uid;
    this.name = name;
    this.user = user;
    this.email = email;
    this.ie = ie;
    this.photo = photo;
  }

  void fromJson(String uid, Map<String, dynamic> json) {
    this.uid = uid;
    name = json['name'];
    user = json['user'];
    email = json['email'];
    ie = json['ie'];
    photo = json['photo'] ?? "";
  }
}