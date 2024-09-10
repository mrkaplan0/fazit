import 'package:hive/hive.dart';

class LocalServices {
  var wrongsBox = Hive.box('myWrongs');
  var favoritesBox = Hive.box("favorites");

  bool addWrongToLocal(String cardID) {
    try {
      wrongsBox.put(cardID, cardID);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool deleteWrongFromLocal(String cardID) {
    try {
      wrongsBox.delete(cardID);
      return true;
    } catch (e) {
      return false;
    }
  }

  List<String> fetchMyWrongs() {
    List<String> listIDs = [];

    wrongsBox.values.map((e) {
      listIDs.add(e.toString());
    }).toList();

    return listIDs;
  }

  bool checkwrongscardIDFromLocal(String cardID) {
    try {
      return wrongsBox.containsKey(cardID);
    } catch (e) {
      return false;
    }
  }

  bool addFavoriteToLocal(String cardID) {
    try {
      favoritesBox.put(cardID, cardID);
      return checkcardIDFromLocal(cardID);
    } catch (e) {
      return false;
    }
  }

  bool deleteFavoriteFromLocal(String cardID) {
    try {
      favoritesBox.delete(cardID);
      return !checkcardIDFromLocal(cardID);
    } catch (e) {
      return false;
    }
  }

  bool checkcardIDFromLocal(String cardID) {
    try {
      return favoritesBox.containsKey(cardID);
    } catch (e) {
      return false;
    }
  }

  List<String> fetchMyFavorites() {
    List<String> listIDs = [];

    favoritesBox.values.map((e) {
      listIDs.add(e.toString());
    }).toList();

    return listIDs;
  }
}
