import 'package:fazitadmin/models/user.dart';
import 'package:fazitadmin/services/delegates/auth_delegate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuthService>((ref) {
  return FirebaseAuthService();
});

class FirebaseAuthService implements MyAuthenticationDelegate {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  MyUser? myUser;

  MyUser _usersFromFirebase(User user) {
    return MyUser(
        userID: user.uid,
        email: user.email!,
        createdDate: DateTime.now(),
        validationDate: DateTime.now(),
        isTeacher: false,
        isAdmin: false,
        branch: null);
  }

  @override
  Future<MyUser?> currentUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return _usersFromFirebase(user);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint("Hata CurrentUser $e");
      return null;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential sonuc = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return _usersFromFirebase(sonuc.user!);
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential sonuc = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return _usersFromFirebase(sonuc.user!);
    } on FirebaseAuthException catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      debugPrint("Hata SignOut $e");
      return false;
    }
  }

  @override
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      debugPrint("Hata SignOut $e");
      return false;
    }
  }
}
