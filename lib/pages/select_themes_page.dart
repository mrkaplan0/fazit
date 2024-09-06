import "package:fazit/models/infocart_model.dart";
import "package:fazit/pages/card_detail_page.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class SelectThemesPage extends ConsumerWidget {
  SelectThemesPage({super.key});
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
                      builder: (context) => CardDetailPage(learnThemes[i], [
                        MyCard(
                            cardID: "ycytxc",
                            theme: learnThemes[i],
                            frontNoteFormat: FrontNoteFormat.onlyText,
                            backNoteFormat: BackNoteFormat.photoAndText,
                            frontSideNote: "aaaaaaaaaaaaaaaaaaaa",
                            backSideNote:
                                """aksdjfhlasdkuhfasdklöj What is Lorem Ipsum?
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.What is Lorem Ipsum?
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.What is Lorem Ipsum?
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.""",
                            lastUpdatedTime: DateTime.now()),
                        MyCard(
                            cardID: "ycywxc",
                            theme: learnThemes[i],
                            frontNoteFormat: FrontNoteFormat.onlyText,
                            backNoteFormat: BackNoteFormat.photoAndText,
                            frontSideNote: "sssssssssssssssssssssss",
                            backSideNote: "aksdjfhlasdkuhfasdklöj",
                            lastUpdatedTime: DateTime.now()),
                        MyCard(
                            cardID: "yczryxc",
                            theme: learnThemes[i],
                            frontNoteFormat: FrontNoteFormat.onlyText,
                            backNoteFormat: BackNoteFormat.photoAndText,
                            frontSideNote:
                                "dddddddddddddddddddddddddcyxyyyyyyyyyyyyyyyyyyyyyfgdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
                            backSideNote: "aksdjfhlasdkuhfasdklöj",
                            lastUpdatedTime: DateTime.now())
                      ]),
                    ));
                  },
                ),
              );
            }),
      ),
    );
  }
}
