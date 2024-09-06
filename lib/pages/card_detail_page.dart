import 'dart:math';

import 'package:fazit/models/infocart_model.dart';
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

final displayFrontProvider = StateProvider<bool>((ref) {
  return true;
});

class CardDetailPage extends ConsumerStatefulWidget {
  const CardDetailPage(this.title, this.cardList, {super.key});
  final List<MyCard>? cardList;
  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CardDetailPageState();
}

class _CardDetailPageState extends ConsumerState<CardDetailPage> {
  @override
  Widget build(BuildContext context) {
    final cardHeight = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Stack(
          children: widget.cardList!.map((card) {
            int index = widget.cardList!.indexOf(card);
            return Dismissible(
              key: Key(card.cardID),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                setState(() {
                  widget.cardList!.removeAt(index);
                });
                if (direction == DismissDirection.endToStart) {
                  // Handle left swipe
                  print("Swiped left on card $index");
                } else if (direction == DismissDirection.startToEnd) {
                  // Handle right swipe
                  print("Swiped right on card $index");
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
                  ref.read(displayFrontProvider.notifier).state =
                      !ref.read(displayFrontProvider);
                },
                child: Padding(
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
              ),
            );
          }).toList(),
        ),
      ),
    );
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildFrontSide(myCard),
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildBackSide(myCard),
              ),
            ),
          )),
    );
  }

  List<Widget> _buildBackSide(MyCard card) {
    List<Widget> mainBody;

    switch (card.backNoteFormat) {
      case BackNoteFormat.onlyText:
        mainBody = [onlyText(card.backSideNote ?? "")];
        break;
      case BackNoteFormat.photoAndText:
        mainBody = [
          imageWidget(card.backSideURL),
          const SizedBox(height: 10),
          onlyText(card.backSideNote ?? "")
        ];
        break;
      case BackNoteFormat.textandPhoto:
        mainBody = [
          onlyText(card.backSideNote ?? ""),
          const SizedBox(height: 10),
          imageWidget(card.backSideURL)
        ];
        break;
      default:
        mainBody = [onlyText(card.backSideNote ?? "")];
    }

    return mainBody;
  }

  List<Widget> _buildFrontSide(MyCard card) {
    List<Widget> mainBody;

    switch (card.frontNoteFormat) {
      case FrontNoteFormat.onlyText:
        mainBody = [onlyText(card.frontSideNote ?? "")];
        break;
      case FrontNoteFormat.photoAndText:
        mainBody = [
          imageWidget(card.frontSideURL),
          onlyText(card.frontSideNote ?? "")
        ];
        break;
      case FrontNoteFormat.textandPhoto:
        mainBody = [
          onlyText(card.frontSideNote ?? ""),
          imageWidget(card.frontSideURL)
        ];
        break;
      default:
        mainBody = [onlyText(card.frontSideNote ?? "")];
    }

    return mainBody;
  }

  Text onlyText(String text) {
    return Text(text);
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
}
