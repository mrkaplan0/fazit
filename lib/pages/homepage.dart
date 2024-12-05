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
    fetchCards(ref);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            "assets/fazit_text.png",
            height: 35,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
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
                icon: Icons.error_outline_rounded,
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
}
