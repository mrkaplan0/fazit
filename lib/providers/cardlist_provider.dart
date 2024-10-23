import 'package:fazit/models/infocart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardListNotifier extends FamilyNotifier<List<MyCard>, List<MyCard>> {
  List<MyCard> removedCards = [];
  @override
  build(arg) {
    return arg;
  }

  removeCardAtIndex(int i) {
    removedCards.add(state[i]);
    state.removeAt(i);
  }

  undoLastCard() {
    if (removedCards.isNotEmpty) {
      state.insert(0, removedCards.last);
    } else {
      return;
    }
  }

  addFilteredCardToFirst(MyCard filteredCard) {
    int index = state.indexWhere((card) => card.cardID == filteredCard.cardID);
    state.removeAt(index);
    state.insert(0, filteredCard);
  }

  mixCard() {
    state.shuffle();
  }
}
