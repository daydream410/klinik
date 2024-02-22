// ignore_for_file: avoid_print

import 'package:alert/alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  // final CollectionReference layananList = FirebaseFirestore.instance.collection('layanan');

// authentication register with firebase
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("terdaftar ${e.code}");
        Alert(message: 'Email Sudah Terdaftar.').show();
      } else {
        Alert(message: 'Error : ${e.code}').show();
      }
    }
    return null;
  }

// authentication login with firebase
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        Alert(message: 'Email / Password Salah.').show();
      } else if (e.code == 'invalid-email') {
        Alert(message: 'Format Email Salah.').show();
      } else {
        Alert(message: 'Error : ${e.code}').show();
      }
    }
    return null;
  }
}
