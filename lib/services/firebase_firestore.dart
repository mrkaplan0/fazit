import 'package:fazitadmin/models/infocart_model.dart';
import 'package:fazitadmin/models/user.dart';
import 'package:fazitadmin/services/delegates/database_delegate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreService implements MyDatabaseDelegate {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<bool> saveMyUser(MyUser user) async {
    try {
      await db
          .collection('Users')
          .doc(user.userID)
          .set(user.toMap(), SetOptions(merge: true));
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<MyUser?> readMyUser(String userId) async {
    MyUser? user;
    try {
      DocumentSnapshot okunanUser =
          await db.collection('Users').doc(userId).get();

      user = MyUser.fromMap(okunanUser.data() as Map<String, dynamic>);

      debugPrint("Okunan user nesnesi $user");
    } catch (e) {
      print(e);
    }
    return user;
  }

  @override
  Future<bool> addCard(MyCard card) async {
    try {
      await db
          .collection("Cards")
          .doc("Cards")
          .set({card.cardID: card.toMap()}, SetOptions(merge: true));

      return true;
    } on Exception catch (e) {
      return false;
    }
  }
}
