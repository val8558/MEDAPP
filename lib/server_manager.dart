// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:medapp/models/question_data.dart';
import 'package:medapp/models/question_theme_data.dart';
import 'package:medapp/models/user_data.dart';

class ServerManager{
  static User? user = FirebaseAuth.instance.currentUser;
  static String uid = user == null? "": user!.uid;
  static FirebaseFirestore fb = FirebaseFirestore.instance;

  static Future<UserData?> createUser({
    required BuildContext context,
    required String name,
    required String user,
    required String email,
    required String password,
    required String ie
  }) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      await fb.collection("users").doc(userCredential.user!.uid)
      .set({
        "name": name,
        "user": user,
        "email": email,
        "ie": ie
      });

      return UserData()
      ..initialize(
        uid: userCredential.user!.uid,
        name: name,
        user: user,
        email: email,
        ie: ie,
      );
    }
    on FirebaseAuthException catch (e){
      print("Erro: $e");
      return null;
    }
  }

  static Future<bool> login({
    required String email,
    required String password
  }) async{
    if(email.isEmpty || password.isEmpty){
      return false;
    }

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      return true;
    }
    on FirebaseAuthException catch (e){
      print("Erro: $e");
      return false;
    }
  }

  static Future<UserData?> getUserData() async{
    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot doc = await fb.collection("users").doc(uid).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      UserData().fromJson(uid, data);
      return UserData();
    }
    on FirebaseAuthException catch (e){
      print("Erro: $e");
      return null;
    }
  }

  static Future<Map<int, List<int>>> getUsage(String year) async{
    try{
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot doc = await fb.collection("users").doc(uid).collection('usage').doc(year).get();
      if (!doc.exists) {
        return {};
      }

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Map<int, List<int>> usageMap = {};

      data.forEach((key, value) {
        int month = int.parse(key);
        List<int> days = List<int>.from(value);
        usageMap[month] = days;
      });

      return usageMap;
    }
    on FirebaseAuthException catch (e){
      print("Erro: $e");
      return {};
    }
  }

  static Future<QuestionData?> getQuestionData(String id) async{
    try{
      DocumentSnapshot doc = await fb.collection("questions").doc(id).get();
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      return QuestionData(data);
    }
    on FirebaseAuthException catch (e){
      print("Erro: $e");
      return null;
    }
  }

  static Future<List<QuestionData>?> getQuestionsData({String theme = ''}) async{
    try{
      Query query = fb.collection("questions");
      if(theme.isNotEmpty){
        query = query.where("theme", arrayContains: theme);
      }
      
      QuerySnapshot querySnapshot = await query.get();
      List<QuestionData> questions = [];

      for (var element in querySnapshot.docs) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        questions.add(QuestionData(data));
      }

      return questions;
    }
    on FirebaseAuthException catch (e){
      print("Erro: $e");
      return null;
    }
  }

  static Future<List<QuestionThemeData>?> getThemes(String type) async{
    try{
      QuerySnapshot query = await fb.collection("themes").where("type", isEqualTo: type).get();
      List<QuestionThemeData> themes = [];
      for (var element in query.docs) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        themes.add(QuestionThemeData(element.id, data));
      }

      return themes;
    }
    on FirebaseAuthException catch (e){
      print("Erro: $e");
      return null;
    }
  }
}