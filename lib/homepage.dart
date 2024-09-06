import 'package:fazit/pages/books_main.dart';
import 'package:fazit/pages/select_themes_page.dart';
import 'package:fazit/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Image.asset(
            "assets/fazit_text.png",
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
                text: "KarteiKarten",
                icon: Icons.class_rounded,
                onPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectThemesPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
