import 'package:fazit/books_main.dart';
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
      appBar: AppBar(title: const Text("Fachinformatiker")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
