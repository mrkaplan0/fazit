import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/models/user_model.dart';

abstract class MyDatabaseDelegate {
  Future<bool> saveMyUser(MyUser user);
  Future<MyUser?> readMyUser(String userId);
  Future<bool> addCard(MyCard card);
}
