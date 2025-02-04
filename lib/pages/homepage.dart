import 'dart:io';

import 'package:fazit/contrast.dart';
import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/pages/books_main.dart';
import 'package:fazit/pages/my_favorites_page.dart';
import 'package:fazit/pages/select_themes_page.dart';
import 'package:fazit/providers/providers.dart';
import 'package:fazit/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class HomePage extends ConsumerWidget {
  HomePage({super.key});
  List<MyCard> cardList = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var width = MediaQuery.of(context).size.width;
    final themeMode = ref.watch(themeModeProvider);
    fetchCards(ref);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBarLogoWidget,
        actions: [changeThemeButton(themeMode, ref), logoutButton(ref)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal:
                  Platform.isAndroid || Platform.isIOS ? 8.0 : width * 1 / 4),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.end,
            runAlignment: WrapAlignment.end,
            children: [
              MenuItem(
                text: "Bücher",
                icon: Icons.menu_book,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BooksMainpage()));
                },
              ),
              MenuItem(
                text: "Karteikarten",
                icon: Icons.class_rounded,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SelectThemesPage(cardList: cardList)));
                },
              ),
              MenuItem(
                text: "Meine Favorite",
                icon: Icons.favorite,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyFavoritesPage(cardList: cardList)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fetchCards(WidgetRef ref) async {
    cardList = await ref.read(fetchCardsProvider.future);
  }

  Padding logoutButton(WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: IconButton(
        onPressed: () async {
          await ref.watch(userViewModelProvider).signOut();
        },
        tooltip: "Abmelden",
        icon: const Icon(Icons.logout),
      ),
    );
  }

  IconButton changeThemeButton(ThemeMode themeMode, WidgetRef ref) {
    return IconButton(
      onPressed: () {
        // to change theme
        themeMode == ThemeMode.light
            ? ref.read(themeModeProvider.notifier).state = ThemeMode.dark
            : ref.read(themeModeProvider.notifier).state = ThemeMode.light;
      },
      icon: themeMode == ThemeMode.light
          ? const Icon(Icons.light_mode)
          : const Icon(Icons.dark_mode),
    );
  }
}
