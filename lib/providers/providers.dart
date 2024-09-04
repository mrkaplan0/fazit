import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/services/firebase_auth.dart';
import 'package:fazit/services/firebase_firestore.dart';
import 'package:fazit/viewModels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

final firestoreProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

//user model
final userViewModelProvider = ChangeNotifierProvider((_) => UserViewModel());

final textEditingProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  TextEditingController editingController = TextEditingController();
  return editingController;
});

final addcardProvider = FutureProvider.family<bool, MyCard>((ref, card) async {
  var result = await ref.read(firestoreProvider).addCard(card);
  return result;
});