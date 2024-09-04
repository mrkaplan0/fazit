import 'package:fazitadmin/models/user.dart';

abstract class MyAuthenticationDelegate {
  Future<MyUser?> currentUser();
  Future<MyUser?> createUserWithEmailAndPassword(String email, String password);
  Future<MyUser?> signInWithEmailAndPassword(String email, String password);
  Future<bool> signOut();
  Future<bool> resetPassword(String email);
}
