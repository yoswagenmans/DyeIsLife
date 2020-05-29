import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';


class AuthImplementation {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String currentUser;

  static Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    currentUser = user.uid;
    return user.uid;
  }
  static Future<String> signUp(String email, String password) async {
        AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    currentUser = user.uid;
    return user.uid;
  }

  static Future<String> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user == null) {
      return null;
    }
    currentUser = user.uid;
    print(user.uid);
    return user.uid;
  }

  static Future<void> signOut() async {
    print("it called the sign out method");
    currentUser = "";
    _firebaseAuth.signOut();    
  }
}
