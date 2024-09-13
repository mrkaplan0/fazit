import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/pages/card_detail_page.dart';
import 'package:fazit/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyFavoritesPage extends ConsumerWidget {
  const MyFavoritesPage({super.key, required this.cardList});
  final List<MyCard> cardList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CardDetailPage("Meine Favorite", fetchMyFavorites(ref));
  }

  List<MyCard> fetchMyFavorites(WidgetRef ref) {
    var cardIDsList = ref.read(localServiceProvider).fetchMyFavorites();

    return cardList.where((card) => cardIDsList.contains(card.cardID)).toList();
  }
}
