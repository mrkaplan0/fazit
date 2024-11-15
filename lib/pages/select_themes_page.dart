import "package:fazit/contrast.dart";
import "package:fazit/models/infocart_model.dart";
import "package:fazit/pages/card_detail_page.dart";
import "package:flutter/material.dart";

class SelectThemesPage extends StatefulWidget {
  const SelectThemesPage({super.key, required this.cardList});
  final List<MyCard> cardList;

  @override
  State<SelectThemesPage> createState() => _SelectThemesPageState();
}

class _SelectThemesPageState extends State<SelectThemesPage> {
  final _myListKey = GlobalKey<AnimatedListState>();

  bool startAnimation = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _myListKey,
      appBar: AppBar(
        title: const Text("Themen"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: learnThemes.length,
            itemBuilder: (context, i) {
              return AnimatedContainer(
                  curve: Curves.easeInOut,
                  duration: Duration(milliseconds: 400 + (i * 150)),
                  transform: Matrix4.translationValues(
                      startAnimation ? 0 : screenWidth, 0, 0),
                  child: cardinListWidget(i, context));
            },
          )),
    );
  }

  Card cardinListWidget(int i, BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(learnThemes[i]),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Colors.grey[300],
        ),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CardDetailPage(learnThemes[i], cardsByTheme(learnThemes[i])),
          ));
        },
      ),
    );
  }

  List<MyCard> cardsByTheme(String theme) {
    switch (theme) {
      case "Allegemein":
        return widget.cardList;
      case "Verwaltungssoftware":
        return widget.cardList
            .where((card) =>
                card.theme.contains(theme) ||
                card.theme.contains("Python") ||
                card.theme.contains("SQL-Datenbanksprache"))
            .toList();
      default:
        return widget.cardList
            .where((card) => card.theme.contains(theme))
            .toList();
    }
  }
}
