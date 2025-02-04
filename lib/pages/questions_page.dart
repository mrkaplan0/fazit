import 'dart:io';

import 'package:fazit/contrast.dart';
import 'package:fazit/models/card_model.dart';
import 'package:fazit/models/question.dart';
import 'package:fazit/providers/providers.dart';
import 'package:fazit/widgets/animated_progr_indicator.dart';
import 'package:fazit/widgets/animation_switcher.dart';
import 'package:fazit/widgets/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsPage extends ConsumerStatefulWidget {
  const QuestionsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends ConsumerState<QuestionsPage> {
  // List<Question> questions = [];
  bool isClicked = false;
  Set<int> selectedIndexes = {};
  @override
  void initState() {
    super.initState();
    //fetchQuestions();
  }

  void fetchQuestions() async {
    // questions = await ref.read(fetchQuestionsProvider.future);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Fragen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: ref.watch(fetchQuestionsProvider).when(
              data: (questions) {
                return PageView.builder(
                  controller: ref.watch(myPageController),
                  itemCount: questions.length,
                  onPageChanged: (index) {
                    setState(() {
                      isClicked = false;
                      selectedIndexes.clear();
                    });
                  },
                  itemBuilder: (context, i) {
                    return Platform.isAndroid || Platform.isIOS
                        ? mainColumnForMobile(size, questions, i)
                        : mainRowForWindows(size, questions, i);
                  },
                );
              },
              error: (error, stackTrace) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ein Problem ist aufgetreten."),
                  ElevatedButton(
                    onPressed: () => ref.refresh(fetchQuestionsProvider),
                    child: Text("Erneut versuchen"),
                  ),
                ],
              ),
              loading: () => Center(child: ContainerProgressIndicator()),
            ));
  }

  Row mainRowForWindows(Size size, List<Question> questions, int i) {
    return Row(
      children: [
        SizedBox(width: size.width / 4),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _cardFront(questions[i]),
                      questions[i].answers.length > 1
                          ? multipleChoiceAnswers(questions, i)
                          : textAnswer(size.height, questions[i]),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    previousButton(),
                    isClicked ? nextButton() : showTrueAnswerButton(),
                  ],
                ),
              )
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: taggedCardsWidget(questions[i], size),
            ),
          ],
        )
      ],
    );
  }

  Widget mainColumnForMobile(Size size, List<Question> questions, int i) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _cardFront(questions[i]),
                  questions[i].answers.length > 1
                      ? multipleChoiceAnswers(questions, i)
                      : textAnswer(size.height, questions[i]),
                ],
              ),
            ),
          ),
          Expanded(
            child: taggedCardsWidget(questions[i], size),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                previousButton(),
                isClicked ? nextButton() : showTrueAnswerButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget taggedCardsWidget(Question question, Size size) {
    return isClicked && question.tags != null && question.tags!.isNotEmpty
        ? AnimatedSwitcherWidget(
            delayedDuration: 1,
            duration: 1,
            widget1: SizedBox(width: size.width / 4),
            widget2: Container(
              width: Platform.isAndroid || Platform.isIOS
                  ? size.width
                  : size.width / 4,
              decoration: BoxDecoration(
                  color: nonActiveButtonColorDark.withAlpha(30),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  scrollDirection: Platform.isAndroid || Platform.isIOS
                      ? Axis.horizontal
                      : Axis.vertical,
                  shrinkWrap: true,
                  itemCount: question.tags?.length,
                  itemBuilder: (context, tagsIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 200,
                        height: 30,
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  var screenSize = MediaQuery.of(context).size;
                                  return Dialog(
                                    child: SizedBox(
                                      height:
                                          Platform.isAndroid || Platform.isIOS
                                              ? screenSize.height / 2
                                              : screenSize.height / 3,
                                      width:
                                          Platform.isAndroid || Platform.isIOS
                                              ? screenSize.width
                                              : screenSize.width / 2,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 15.0, right: 15.0),
                                        child: Center(
                                          child: MyTextWidget(
                                            text: question.tags?[tagsIndex]
                                                    .backSideNote ??
                                                "",
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: MyTextWidget(
                                text: question.tags?[tagsIndex].frontSideNote ??
                                    "")),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        : SizedBox(width: size.width / 4);
  }

  Widget textAnswer(double height, Question question) {
    if (isClicked) {
      return AnimatedSwitcherWidget(
        duration: 1,
        widget1: SizedBox(),
        widget2: _cardBack(height, question),
        delayedDuration: 0,
      );
    } else {
      return SizedBox();
    }
  }

  Widget multipleChoiceAnswers(List<Question> questions, int i) {
    return Column(
      spacing: 30,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: questions[i].answers.length,
          itemBuilder: (context, index) {
            var q = questions[i];

            return Padding(
              padding: EdgeInsets.only(top: 12),
              child: ElevatedButton.icon(
                  icon: selectedIndexes.contains(index)
                      ? Icon(Icons.radio_button_checked_rounded)
                      : Icon(Icons.radio_button_unchecked_rounded),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: isClicked
                          ? changeColor(
                              q.correctAnswersIndexes!.contains(index))
                          : null),
                  onPressed: () {
                    if (isClicked != true) {
                      if (selectedIndexes.contains(index)) {
                        selectedIndexes.remove(index);
                      } else {
                        selectedIndexes.add(index);
                      }
                    }
                    setState(() {});
                  },
                  label: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextWidget(text: q.answers[index]),
                  )),
            );
          },
        ),
        if (isClicked && selectedIndexes.isNotEmpty)
          if (selectedIndexes
                  .difference((questions[i].correctAnswersIndexes!).toSet())
                  .isEmpty &&
              selectedIndexes.length ==
                  questions[i].correctAnswersIndexes!.length)
            Text("Korrekte Antwort")
          else
            Text("Falsche Antwort")
      ],
    );
  }

  ElevatedButton showTrueAnswerButton() {
    final theme = Theme.of(context);
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12),
          alignment: Alignment.topCenter,
          backgroundColor: ref.watch(themeModeProvider) != ThemeMode.dark
              ? theme.primaryColor
              : null,
          foregroundColor: ref.watch(themeModeProvider) != ThemeMode.dark
              ? theme.cardColor
              : null,
          iconColor: ref.watch(themeModeProvider) != ThemeMode.dark
              ? theme.cardColor
              : null,
        ),
        iconAlignment: IconAlignment.end,
        icon: const Icon(
          Icons.arrow_circle_right,
          size: 30,
        ),
        onPressed: () {
          setState(() {
            isClicked = !isClicked;
          });
        },
        label: Text(
          "Richtige Antwort",
        ));
  }

  IconButton previousButton() {
    return IconButton.filled(
        style: myIconbuttonStyle,
        hoverColor: myIconButtonHoverColor,
        onPressed: () {
          isClicked = false;
          selectedIndexes.clear();
          ref.read(myPageController.notifier).state.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        icon: const Icon(Icons.arrow_left_outlined));
  }

  IconButton showTaggedCards() {
    return IconButton.filled(
        style: myIconbuttonStyle,
        hoverColor: myIconButtonHoverColor,
        onPressed: () {
          isClicked = false;
          selectedIndexes.clear();
          ref.read(myPageController.notifier).state.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear);
        },
        icon: const Icon(Icons.arrow_left_outlined));
  }

  IconButton nextButton() {
    return IconButton.filled(
        style: myIconbuttonStyle,
        hoverColor: myIconButtonHoverColor,
        onPressed: () {
          isClicked = false;
          selectedIndexes.clear();
          ref.read(myPageController.notifier).state.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        },
        icon: const Icon(Icons.arrow_right_rounded));
  }

  Widget _cardFront(Question q) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: activeButtonColorLight.withAlpha(30),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildFrontSide(q),
              ),
            ),
          ),
        ));
  }

  Widget _cardBack(double height, Question q) {
    return Padding(
      padding: EdgeInsets.only(top: 12),
      child: Card(
        key: const ValueKey(false),
        color: ref.watch(themeModeProvider) == ThemeMode.light
            ? cardColorLight
            : cardColorDark,
        elevation: 2,
        child: SizedBox(
            height: height * 3 / 8,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildBackSide(q),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  List<Widget> _buildBackSide(Question q) {
    List<Widget> mainBody = [];
    mainBody = [MyTextWidget(text: q.answers.first)];
    /* switch (q.backNoteFormat) {
      case BackNoteFormat.onlyText:
        
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
        break;
    } */

    return mainBody;
  }

  List<Widget> _buildFrontSide(Question q) {
    List<Widget> mainBody;

    switch (q.frontNoteFormat) {
      case FrontNoteFormat.onlyText:
        mainBody = [MyTextWidget(text: q.question)];
        break;
      case FrontNoteFormat.photoAndText:
        mainBody = [
          imageWidget(q.frontSideURL),
          MyTextWidget(text: q.question)
        ];
        break;
      case FrontNoteFormat.textandPhoto:
        mainBody = [
          MyTextWidget(text: q.question),
          imageWidget(q.frontSideURL)
        ];
        break;
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

  changeColor(bool isTrue) {
    if (isTrue) {
      return const Color.from(
          alpha: 0.732, red: 0.451, green: 0.996, blue: 0.749);
    } else {
      return const Color.fromARGB(129, 249, 81, 131);
    }
  }
}
