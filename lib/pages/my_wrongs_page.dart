import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/pages/card_detail_page.dart';
import 'package:fazit/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyWrongsPage extends ConsumerWidget {
  const MyWrongsPage({super.key, required this.cardList});
  final List<MyCard> cardList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardDetailPage("Mein Fehler", fetchMyWrongs(ref));
  }

  List<MyCard> fetchMyWrongs(WidgetRef ref) {
    var cardIDsList = ref.read(localServiceProvider).fetchMyWrongs();

    return cardList.where((card) => cardIDsList.contains(card.cardID)).toList();
  }
}
