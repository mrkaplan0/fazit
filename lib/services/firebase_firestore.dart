import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/models/user_model.dart';
import 'package:fazit/services/delegates/database_delegate.dart';
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
      debugPrint(e.toString());
    }
    return user;
  }

  @override
  Future<List<MyCard>> fetchCards() async {
    List<MyCard> cardList = [];

    try {
      var result = await db.collection("Cards").doc("Cards").get();
      if (result.data() != null) {
        for (var element in result.data()!.values) {
          cardList.add(MyCard.fromMap(element));
        }
      }

      return cardList;
    } catch (e) {
      return cardList;
    }
  }
}
