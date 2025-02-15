import 'package:fazit/models/card_model.dart';
import 'package:fazit/models/question.dart';
import 'package:fazit/services/firebase_auth.dart';
import 'package:fazit/services/firebase_firestore.dart';
import 'package:fazit/services/local_services.dart';
import 'package:fazit/viewModels/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

final firestoreProvider =
    Provider<FirestoreService>((ref) => FirestoreService());

final localServiceProvider = Provider<LocalServices>((ref) => LocalServices());

//user model
final userViewModelProvider = ChangeNotifierProvider((_) => UserViewModel());

//dark/light mode
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  var mode = ref.read(localServiceProvider).loadThemeMode();
  return mode;
});

final textEditingProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  TextEditingController editingController = TextEditingController();
  return editingController;
});

final fetchCardsProvider = FutureProvider<List<MyCard>>((ref) async {
  var result = await ref.read(firestoreProvider).fetchCards();
  return result;
});

final fetchQuestionsProvider = FutureProvider<List<Question>>((ref) async {
  var result = await ref.read(firestoreProvider).fetchQuestions();
  return result;
});

final pageControllerProv =
    Provider.autoDispose<PageController>((ref) => PageController());
final myPageController = StateProvider.autoDispose<PageController>(
    (ref) => ref.read(pageControllerProv));
