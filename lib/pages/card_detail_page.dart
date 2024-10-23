import 'dart:math';
import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/providers/providers.dart';
import 'package:fazit/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

final displayFrontProvider = StateProvider.autoDispose<bool>((ref) {
  return true;
});
final isSearchBarActiveProvider = StateProvider.autoDispose<bool>((ref) {
  return false;
});

class CardDetailPage extends ConsumerStatefulWidget {
  const CardDetailPage(this.title, this.cardList, {super.key});
  final List<MyCard> cardList;
  final String title;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends ConsumerState<CardDetailPage> {
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height * 7 / 9;
    var cardList = ref.watch(cardlistProvider(widget.cardList));
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: ref.watch(isSearchBarActiveProvider)
            ? searchBar(cardList)
            : AppBar(title: Text(widget.title), actions: [
                IconButton(
                    onPressed: () {
                      ref.read(cardlistProvider(cardList).notifier).mixCard();
                    },
                    icon: const Icon(Icons.shuffle)),
                IconButton(
                    onPressed: () {
                      ref.read(isSearchBarActiveProvider.notifier).state =
                          !ref.read(isSearchBarActiveProvider);
                    },
                    icon: ref.watch(isSearchBarActiveProvider)
                        ? const Icon(Icons.cancel)
                        : const Icon(Icons.search)),
              ]),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cardList.length,
                itemBuilder: (context, i) {
                  var card = cardList[i];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    onUpdate: (details) {
                      ref.invalidate(displayFrontProvider);
                    },
                    onDismissed: (direction) {
                      ref
                          .read(cardlistProvider(widget.cardList).notifier)
                          .removeCardAtIndex(i);
                      ref.invalidate(displayFrontProvider);
                      if (direction == DismissDirection.endToStart) {
                        // On left swipe add card to local db as Wrong

                        ref
                            .read(localServiceProvider)
                            .addWrongToLocal(card.cardID);
                      } else if (direction == DismissDirection.startToEnd) {
                        // on right swipe delete wrong card from local db.
                        if (ref
                            .read(localServiceProvider)
                            .checkwrongscardIDFromLocal(card.cardID)) {
                          ref
                              .read(localServiceProvider)
                              .deleteWrongFromLocal(card.cardID);
                        }
                      }
                    },
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.thumb_up, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: const Icon(Icons.thumb_down, color: Colors.white),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print(ref.read(displayFrontProvider.notifier).state =
                            !ref.read(displayFrontProvider));
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 600),
                                switchInCurve: Curves.easeInBack,
                                switchOutCurve: Curves.easeInBack.flipped,
                                layoutBuilder: (widget, list) =>
                                    Stack(children: [widget!, ...list]),
                                transitionBuilder: _transitionBuilder,
                                child: ref.watch(displayFrontProvider)
                                    ? _cardFront(cardHeight, card)
                                    : _cardBack(cardHeight, card)),
                          ),
                          IconButton.filledTonal(
                              onPressed: () {
                                if (ref
                                    .read(localServiceProvider)
                                    .checkcardIDFromLocal(card.cardID)) {
                                  var result = ref
                                      .read(localServiceProvider)
                                      .deleteFavoriteFromLocal(card.cardID);
                                  if (result) {
                                    ref
                                        .refresh(localServiceProvider)
                                        .checkcardIDFromLocal(card.cardID);
                                  }
                                } else {
                                  var result = ref
                                      .read(localServiceProvider)
                                      .addFavoriteToLocal(card.cardID);

                                  if (result) {
                                    ref
                                        .refresh(localServiceProvider)
                                        .checkcardIDFromLocal(card.cardID);
                                  }
                                }
                              },
                              isSelected: ref
                                  .watch(localServiceProvider)
                                  .checkcardIDFromLocal(card.cardID),
                              icon: const Icon(Icons.star_border_outlined),
                              selectedIcon: const Icon(Icons.star))
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder =
            (ValueKey(ref.watch(displayFrontProvider)) != widget?.key);

        final value =
            isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: Matrix4.rotationY(value)..setEntry(3, 2, 0.001),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _cardFront(double height, MyCard myCard) {
    return Card(
      key: const ValueKey(true),
      color: Colors.white,
      elevation: 4,
      child: Container(
          padding: const EdgeInsets.all(16.0),
          height: height,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildFrontSide(myCard),
                ),
              ),
            ),
          )),
    );
  }

  Widget _cardBack(double height, MyCard myCard) {
    return Card(
      key: const ValueKey(false),
      color: Colors.white,
      elevation: 4,
      child: Container(
          padding: const EdgeInsets.all(16.0),
          height: height,
          width: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildBackSide(myCard),
                ),
              ),
            ),
          )),
    );
  }

  List<Widget> _buildBackSide(MyCard card) {
    List<Widget> mainBody;

    switch (card.backNoteFormat) {
      case BackNoteFormat.onlyText:
        mainBody = [MyTextWidget(text: card.backSideNote ?? "")];
        break;
      case BackNoteFormat.photoAndText:
        mainBody = [
          imageWidget(card.backSideURL),
          const SizedBox(height: 10),
          MyTextWidget(text: card.backSideNote ?? "")
        ];
        break;
      case BackNoteFormat.textandPhoto:
        mainBody = [
          MyTextWidget(text: card.backSideNote ?? ""),
          const SizedBox(height: 10),
          imageWidget(card.backSideURL)
        ];
        break;
      default:
        mainBody = [MyTextWidget(text: card.backSideNote ?? "")];
    }

    return mainBody;
  }

  List<Widget> _buildFrontSide(MyCard card) {
    List<Widget> mainBody;

    switch (card.frontNoteFormat) {
      case FrontNoteFormat.onlyText:
        mainBody = [MyTextWidget(text: card.frontSideNote ?? "")];
        break;
      case FrontNoteFormat.photoAndText:
        mainBody = [
          imageWidget(card.frontSideURL),
          MyTextWidget(text: card.frontSideNote ?? "")
        ];
        break;
      case FrontNoteFormat.textandPhoto:
        mainBody = [
          MyTextWidget(text: card.frontSideNote ?? ""),
          imageWidget(card.frontSideURL)
        ];
        break;
      default:
        mainBody = [MyTextWidget(text: card.frontSideNote ?? "")];
    }

    return mainBody;
  }

  Image imageWidget(String? url) {
    if (url != null) {
      return Image.network(url);
    } else {
      return Image.asset(
        "assets/image_error.png",
        width: 200,
      );
    }
  }

  PreferredSizeWidget searchBar(List<MyCard> cardList) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(170),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SearchAnchor(
            viewBackgroundColor: Colors.white,
            builder: (context, controller) {
              return SearchBar(
                focusNode: focusNode,
                autoFocus: true,
                leading: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                trailing: [
                  IconButton(
                      onPressed: () {
                        ref.invalidate(isSearchBarActiveProvider);
                      },
                      icon: const Icon(Icons.cancel))
                ],
                shape: const WidgetStatePropertyAll(RoundedRectangleBorder()),
                backgroundColor: const WidgetStatePropertyAll(Colors.white),
                controller: controller,
                onTap: () {
                  controller.openView();
                },
                onChanged: (input) {
                  controller.openView();
                },
              );
            },
            suggestionsBuilder: (context, controller) {
              String text = controller.text;
              var filteredList = cardList
                  .where((card) => card.frontSideNote!
                      .toLowerCase()
                      .contains(controller.text.toLowerCase()))
                  .toList();
              return List<Card>.generate(filteredList.length, (int index) {
                return Card(
                  child: ListTile(
                    // tileColor: Colors.amber,
                    title: MyTextWidget(
                        text: filteredList[index].frontSideNote ?? ""),
                    onTap: () {
                      ref
                          .read(cardlistProvider(cardList).notifier)
                          .addFilteredCardToFirst(filteredList[index]);
                      setState(() {
                        controller.closeView(text);
                        focusNode.unfocus();
                      });
                    },
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
