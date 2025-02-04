// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum FrontNoteFormat { onlyText, photoAndText, textandPhoto }

enum BackNoteFormat { onlyText, photoAndText, textandPhoto, multiple }

class MyCard {
  final String cardID;
  List<String> theme;
  FrontNoteFormat frontNoteFormat;
  BackNoteFormat backNoteFormat;
  String? frontSideNote;
  String? frontSideURL;
  String? backSideNote;
  String? backSideURL;
  String? sourceInfo;
  DateTime lastUpdatedTime;
  DateTime? lastPracticeTime;
  String createdBy;
  bool? isTrue;
  int? importanceLevel;
  MyCard({
    required this.cardID,
    required this.theme,
    required this.frontNoteFormat,
    required this.backNoteFormat,
    this.frontSideNote,
    this.frontSideURL,
    this.backSideNote,
    this.backSideURL,
    this.sourceInfo,
    required this.lastUpdatedTime,
    this.lastPracticeTime,
    required this.createdBy,
    this.isTrue,
    this.importanceLevel,
  });

  MyCard copyWith({
    String? cardID,
    List<String>? theme,
    FrontNoteFormat? frontNoteFormat,
    BackNoteFormat? backNoteFormat,
    String? frontSideNote,
    String? frontSideURL,
    String? backSideNote,
    String? backSideURL,
    String? sourceInfo,
    DateTime? lastUpdatedTime,
    DateTime? lastPracticeTime,
    String? createdBy,
    bool? isTrue,
    int? importanceLevel,
  }) {
    return MyCard(
      cardID: cardID ?? this.cardID,
      theme: theme ?? this.theme,
      frontNoteFormat: frontNoteFormat ?? this.frontNoteFormat,
      backNoteFormat: backNoteFormat ?? this.backNoteFormat,
      frontSideNote: frontSideNote ?? this.frontSideNote,
      frontSideURL: frontSideURL ?? this.frontSideURL,
      backSideNote: backSideNote ?? this.backSideNote,
      backSideURL: backSideURL ?? this.backSideURL,
      sourceInfo: sourceInfo ?? this.sourceInfo,
      lastUpdatedTime: lastUpdatedTime ?? this.lastUpdatedTime,
      lastPracticeTime: lastPracticeTime ?? this.lastPracticeTime,
      createdBy: createdBy ?? this.createdBy,
      isTrue: isTrue ?? this.isTrue,
      importanceLevel: importanceLevel ?? this.importanceLevel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardID': cardID,
      'theme': theme,
      'frontNoteFormat': frontNoteFormat.name.toString(),
      'backNoteFormat': backNoteFormat.name.toString(),
      'frontSideNote': frontSideNote,
      'frontSideURL': frontSideURL,
      'backSideNote': backSideNote,
      'backSideURL': backSideURL,
      'sourceInfo': sourceInfo,
      'lastUpdatedTime': lastUpdatedTime.millisecondsSinceEpoch,
      'lastPracticeTime': lastPracticeTime?.millisecondsSinceEpoch,
      'createdBy': createdBy,
      'isTrue': isTrue,
      'importanceLevel': importanceLevel,
    };
  }

  MyCard.fromMap(Map<String, dynamic> map)
      : cardID = map['cardID'] as String,
        theme = List<String>.from(map['theme']),
        frontNoteFormat = FrontNoteFormat.values.byName(map['frontNoteFormat']),
        backNoteFormat = BackNoteFormat.values.byName(map['backNoteFormat']),
        frontSideNote = map['frontSideNote'] != null
            ? map['frontSideNote'] as String
            : null,
        frontSideURL =
            map['frontSideURL'] != null ? map['frontSideURL'] as String : null,
        backSideNote = map['backSideNote'] != null
            ? (map['backSideNote'] as String)
            : null,
        backSideURL =
            map['backSideURL'] != null ? map['backSideURL'] as String : null,
        sourceInfo =
            map['sourceInfo'] != null ? map['sourceInfo'] as String : null,
        lastUpdatedTime =
            DateTime.fromMillisecondsSinceEpoch(map['lastUpdatedTime'] as int),
        lastPracticeTime = map['lastPracticeTime'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                map['lastPracticeTime'] as int)
            : null,
        createdBy = map['createdBy'] as String,
        isTrue = map['isTrue'] != null ? map['isTrue'] as bool : null,
        importanceLevel = map['importanceLevel'] != null
            ? map['importanceLevel'] as int
            : null;

  String toJson() => json.encode(toMap());

  static String textMaptoJson(String text) {
    return jsonDecode(text);
  }

  factory MyCard.fromJson(String source) =>
      MyCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyCards(cardID: $cardID, theme: $theme, frontNoteFormat: $frontNoteFormat, backNoteFormat: $backNoteFormat, frontSideNote: $frontSideNote, frontSideURL: $frontSideURL, backSideNote: $backSideNote, backSideURL: $backSideURL, sourceInfo: $sourceInfo, lastUpdatedTime: $lastUpdatedTime, lastPracticeTime: $lastPracticeTime, createdBy: $createdBy, isTrue: $isTrue, importanceLevel: $importanceLevel)';
  }
}
