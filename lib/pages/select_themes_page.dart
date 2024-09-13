import "package:fazit/models/infocart_model.dart";
import "package:fazit/pages/card_detail_page.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class SelectThemesPage extends ConsumerWidget {
  SelectThemesPage({super.key, required this.cardList});
  final List<MyCard> cardList;
  final List<String> learnThemes = [
    "Allegemein",
    "Unternehmen",
    "Arbeitsplatz",
    "Clientsnetzwerke",
    "Schutzbedarfanalyse",
    "Verwaltungssoftware",
    "Serviceanfragen",
    "Cybersysteme",
    "Daten",
    "Netzwerke und Dienste"
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Themen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: learnThemes.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text(learnThemes[i]),
                  trailing: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.grey[300],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CardDetailPage(
                          learnThemes[i], cardsByTheme(learnThemes[i])),
                    ));
                  },
                ),
              );
            }),
      ),
    );
  }

  List<MyCard> cardsByTheme(String theme) {
    List<MyCard> list = [];
    for (var e in cardList) {
      if (e.theme == theme) {
        list.add(e);
      }
    }
    return list;
  }
}
