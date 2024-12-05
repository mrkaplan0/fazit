import 'dart:math';
import 'package:fazit/contrast.dart';
import 'package:fazit/models/infocart_model.dart';
import 'package:fazit/providers/providers.dart';
import 'package:fazit/widgets/my_card_widget.dart';
import 'package:fazit/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:carousel_slider/carousel_slider.dart';

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
  List<MyCard> filteredList = [];
  List<MyCardWidget> cards = [];
  late CarouselSliderController _carouselSliderController;
  @override
  void initState() {
    super.initState();
    cards = List.generate(
        widget.cardList.length,
        (i) => MyCardWidget(
              card: widget.cardList[i],
            ));
    _carouselSliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ref.watch(themeModeProvider) == ThemeMode.light
            ? Colors.grey[300]
            : null,
        appBar: ref.watch(isSearchBarActiveProvider)
            ? searchBar(widget.cardList)
            : AppBar(title: Text(widget.title), actions: [
                IconButton(
                    onPressed: () {
                      cards.shuffle();
                      _carouselSliderController.animateToPage(0);
                    },
                    icon: const Icon(Icons.shuffle)),
                //button to activate searcbar
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
              child: CarouselSlider(
                  carouselController: _carouselSliderController,
                  items: cards,
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      ref.invalidate(
                          displayFrontProvider); // to reset display side of card
                    },
                    scrollDirection: Axis.horizontal,
                  )),
            ),
          ],
        ));
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
                        filteredList.clear();
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
              filteredList = cardList
                  .where((card) => card.frontSideNote!
                      .toLowerCase()
                      .contains(controller.text.toLowerCase()))
                  .toList();
              return List<Card>.generate(filteredList.length, (int index) {
                return Card(
                  child: ListTile(
                    title: MyTextWidget(
                        text: filteredList[index].frontSideNote ?? ""),
                    onTap: () {
                      var i = cardList.indexWhere(
                          (card) => card.cardID == filteredList[index].cardID);
                      _carouselSliderController.animateToPage(i);

                      filteredList.clear();
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
