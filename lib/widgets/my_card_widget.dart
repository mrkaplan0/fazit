import 'dart:math';

import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/pages/card_detail_page.dart';
import 'package:fazit/providers/providers.dart';
import 'package:fazit/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCardWidget extends ConsumerStatefulWidget {
  const MyCardWidget({super.key, required this.card});
  final MyCard card;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends ConsumerState<MyCardWidget> {
  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height * 7 / 9;

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          ref.read(displayFrontProvider.notifier).state =
              !ref.read(displayFrontProvider);
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
                      ? _cardFront(cardHeight, widget.card)
                      : _cardBack(cardHeight, widget.card)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(width: 30),
                favoriteButton(widget.card),
                infoIconButton(context, widget.card),
              ],
            )
          ],
        ),
      ),
    );
  }

  IconButton undoIconButton() {
    return IconButton(
        onPressed: () {
          //  ref.read(cardlistProvider(widget.cardList).notifier).undoLastCard();
        },
        icon: const Icon(
          Icons.undo_rounded,
          color: Colors.grey,
        ));
  }

  IconButton infoIconButton(BuildContext context, MyCard card) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              shape: Border.all(color: Colors.black54),
              titleTextStyle:
                  const TextStyle(fontSize: 20, color: Colors.black87),
              title: const Text("Letzte Aktualisierungszeit:"),
              content: Text(card.lastUpdatedTime.toString()),
            ),
          );
        },
        icon: const Icon(
          Icons.info_outline_rounded,
          color: Colors.grey,
        ));
  }

  IconButton favoriteButton(MyCard card) {
    return IconButton.filledTonal(
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
            var result =
                ref.read(localServiceProvider).addFavoriteToLocal(card.cardID);

            if (result) {
              ref
                  .refresh(localServiceProvider)
                  .checkcardIDFromLocal(card.cardID);
            }
          }
        },
        isSelected:
            ref.watch(localServiceProvider).checkcardIDFromLocal(card.cardID),
        icon: const Icon(Icons.star_border_outlined),
        selectedIcon: const Icon(Icons.star));
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
      return Image.network(url, errorBuilder: (context, error, stackTrace) {
        return Image.asset("assets/image_error.png", width: 200);
      });
    } else {
      return Image.asset(
        "assets/image_error.png",
        width: 200,
      );
    }
  }
}
