import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LocalServices {
  var themeBox = Hive.box('myTheme');
  var favoritesBox = Hive.box("favorites");

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

  void saveThemeMode(ThemeMode mode) {
    themeBox.put("themeMode", mode == ThemeMode.dark ? "dark" : "light");
  }

  ThemeMode loadThemeMode() {
    final storedTheme = themeBox.get("themeMode", defaultValue: "light");
    return storedTheme == "dark" ? ThemeMode.dark : ThemeMode.light;
  }

  // Tema modunu değiştirme ve Hive'a kaydetme
  void toggleThemeMode(ThemeMode mode) {
    mode = mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    saveThemeMode(mode);
  }
}
