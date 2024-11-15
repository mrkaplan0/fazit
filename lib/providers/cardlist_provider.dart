import 'package:fazit/models/infocart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardListNotifier extends FamilyNotifier<List<MyCard>, List<MyCard>> {
  List<MyCard> removedCards = [];
  @override
  build(arg) {
    return arg;
  }

  removeCardAtIndex() {
    if (state.isNotEmpty) {
      removedCards.add(state.first);
      state.removeAt(0);
    }
  }

  undoLastCard() {
    if (removedCards.isNotEmpty) {
      final lastCard = removedCards.removeLast();

      state = [lastCard, ...state];
    }
  }

  addFilteredCardToFirst(MyCard filteredCard) {
    int index = state.indexWhere((card) => card.cardID == filteredCard.cardID);
    state.removeAt(index);
    state.insert(0, filteredCard);
  }

  mixCard() {
    state = List.from(state)..shuffle();
  }

  bool isRemovedCardsListEmpty() {
    if (removedCards.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
