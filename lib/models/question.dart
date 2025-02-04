// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:fazit/models/card_model.dart';
import 'package:flutter/foundation.dart';

enum Qtype { text, multiple }

class Question {
  final String questionID;
  Qtype questionType;
  String question;
  FrontNoteFormat frontNoteFormat;
  BackNoteFormat backNoteFormat;
  List<String> answers;
  List<MyCard>? tags;
  String? frontSideURL;
  String? backSideURL;
  List<int>? correctAnswersIndexes;
  Question({
    required this.questionID,
    required this.questionType,
    required this.question,
    required this.frontNoteFormat,
    required this.backNoteFormat,
    required this.answers,
    this.tags,
    this.frontSideURL,
    this.backSideURL,
    this.correctAnswersIndexes,
  });

  Question copyWith({
    String? questionID,
    Qtype? questionType,
    String? question,
    FrontNoteFormat? frontNoteFormat,
    BackNoteFormat? backNoteFormat,
    List<String>? answers,
    List<MyCard>? tags,
    String? frontSideURL,
    String? backSideURL,
    List<int>? correctAnswersIndexes,
  }) {
    return Question(
      questionID: questionID ?? this.questionID,
      questionType: questionType ?? this.questionType,
      question: question ?? this.question,
      frontNoteFormat: frontNoteFormat ?? this.frontNoteFormat,
      backNoteFormat: backNoteFormat ?? this.backNoteFormat,
      answers: answers ?? this.answers,
      tags: tags ?? this.tags,
      frontSideURL: frontSideURL ?? this.frontSideURL,
      backSideURL: backSideURL ?? this.backSideURL,
      correctAnswersIndexes:
          correctAnswersIndexes ?? this.correctAnswersIndexes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questionID': questionID,
      'questionType': questionType.name.toString(),
      'question': question,
      'frontNoteFormat': frontNoteFormat.name.toString(),
      'backNoteFormat': backNoteFormat.name.toString(),
      'answers': answers,
      'tags': tags?.map((x) => x.toMap()).toList(),
      'frontSideURL': frontSideURL,
      'backSideURL': backSideURL,
      'correctAnswersIndexes': correctAnswersIndexes,
    };
  }

  Question.fromMap(Map<String, dynamic> map)
      : questionID = map['questionID'] as String,
        questionType = Qtype.values.byName(map['questionType']),
        question = map['question'] as String,
        frontNoteFormat = FrontNoteFormat.values.byName(map['frontNoteFormat']),
        backNoteFormat = BackNoteFormat.values.byName(map['backNoteFormat']),
        answers = List<String>.from((map['answers'])),
        tags = map['tags'] != null
            ? List<MyCard>.from(
                (map['tags']).map<MyCard?>(
                  (x) => MyCard.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        frontSideURL =
            map['frontSideURL'] != null ? map['frontSideURL'] as String : null,
        backSideURL =
            map['backSideURL'] != null ? map['backSideURL'] as String : null,
        correctAnswersIndexes = map['correctAnswersIndexes'] != null
            ? List<int>.from((map['correctAnswersIndexes']))
            : null;

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(questionID: $questionID, questionType: $questionType, question: $question, frontNoteFormat: $frontNoteFormat, backNoteFormat: $backNoteFormat, answers: $answers, tags: $tags, frontSideURL: $frontSideURL, backSideURL: $backSideURL, correctAnswersIndexes: $correctAnswersIndexes)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.questionID == questionID &&
        other.questionType == questionType &&
        other.question == question &&
        other.frontNoteFormat == frontNoteFormat &&
        other.backNoteFormat == backNoteFormat &&
        listEquals(other.answers, answers) &&
        listEquals(other.tags, tags) &&
        other.frontSideURL == frontSideURL &&
        other.backSideURL == backSideURL &&
        listEquals(other.correctAnswersIndexes, correctAnswersIndexes);
  }

  @override
  int get hashCode {
    return questionID.hashCode ^
        questionType.hashCode ^
        question.hashCode ^
        frontNoteFormat.hashCode ^
        backNoteFormat.hashCode ^
        answers.hashCode ^
        tags.hashCode ^
        frontSideURL.hashCode ^
        backSideURL.hashCode ^
        correctAnswersIndexes.hashCode;
  }
}
