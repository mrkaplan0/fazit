import "dart:io";

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
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _myListKey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Themen"),
      ),
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                width: Platform.isAndroid || Platform.isIOS ? width : width / 3,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    itemCount: learnThemes.length,
                    itemBuilder: (context, i) {
                      return AnimatedContainer(
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 400 + (i * 150)),
                          transform: Matrix4.translationValues(
                              startAnimation ? 0 : width, 0, 0),
                          child: cardinListWidget(i, context));
                    },
                  ),
                ))),
      ),
    );
  }

  Widget cardinListWidget(int i, BuildContext context) {
    return Card(
      child: ListTile(
        leading: iconsByTheme(learnThemes[i]),
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
      default:
        return widget.cardList
            .where((card) => card.theme.contains(theme))
            .toList();
    }
  }

  Icon iconsByTheme(String theme) {
    switch (theme) {
      case "Allegemein":
        return Icon(Icons.class_rounded);
      case "Unternehmen":
        return Icon(Icons.business_outlined);
      case "Arbeitsplatz":
        return Icon(Icons.table_restaurant);
      case "Clientsnetzwerke":
        return Icon(Icons.wifi);
      case "Schutzbedarfanalyse":
        return Icon(Icons.security_rounded);
      case "Verwaltungssoftware":
        return Icon(Icons.app_registration_outlined);
      case "Serviceanfragen":
        return Icon(Icons.miscellaneous_services);
      case "Cybersysteme":
        return Icon(Icons.roofing_rounded);
      case "Daten":
        return Icon(Icons.data_object_outlined);
      case "Netzwerke und Dienste":
        return Icon(Icons.cloud);
      case "Python":
        return Icon(Icons.class_rounded);
      case "SQL-Datenbanksprache":
        return Icon(Icons.class_rounded);
      case "Git-Befehle":
        return Icon(Icons.g_mobiledata_sharp);
      default:
        return Icon(Icons.class_rounded);
    }
  }
}
