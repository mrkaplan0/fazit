import 'package:fazit/models/card_model.dart';
import 'package:fazit/models/question.dart';
import 'package:fazit/models/user_model.dart';

abstract class MyDatabaseDelegate {
  Future<bool> saveMyUser(MyUser user);
  Future<MyUser?> readMyUser(String userId);
  Future<List<MyCard>> fetchCards();
  Future<List<Question>> fetchQuestions();
}
