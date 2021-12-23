import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;

  // no need for parameters since it is anonymous login.
  Future<String?> login() async {
    await auth.signInAnonymously();
    return null;
  }

  Future<void> signout() async {
    await auth.signOut();
  }
}
