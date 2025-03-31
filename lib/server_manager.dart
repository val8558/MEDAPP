// ignore_for_file: avoid_print
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
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
      print("Criando conta");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      print('salvando dados');
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
      DocumentSnapshot user = await fb.collection("users").doc(uid).get();
      Map<String, dynamic> data = user.data() as Map<String, dynamic>;

      UserData().fromJson(uid, data);
      return UserData();
    }
    on FirebaseAuthException catch (e){
      print("Erro: $e");
      return null;
    }
  }
}