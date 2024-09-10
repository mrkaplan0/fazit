// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum FrontNoteFormat { onlyText, photoAndText, textandPhoto }

enum BackNoteFormat { onlyText, photoAndText, textandPhoto }

class MyCard {
  final String cardID;
  String theme;
  FrontNoteFormat frontNoteFormat;
  BackNoteFormat backNoteFormat;
  String? frontSideNote;
  String? frontSideURL;
  String? backSideNote;
  String? backSideURL;
  String? sourceInfo;
  DateTime lastUpdatedTime;
  DateTime? lastPracticeTime;
  bool? isTrue;
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
    this.isTrue,
  });

  MyCard copyWith({
    String? cardID,
    String? theme,
    FrontNoteFormat? frontNoteFormat,
    BackNoteFormat? backNoteFormat,
    String? frontSideNote,
    String? frontSideURL,
    String? backSideNote,
    String? backSideURL,
    String? sourceInfo,
    DateTime? lastUpdatedTime,
    DateTime? lastPracticeTime,
    bool? isTrue,
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
      isTrue: isTrue ?? this.isTrue,
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
      'isTrue': isTrue,
    };
  }

  factory MyCard.fromMap(Map<String, dynamic> map) {
    return MyCard(
      cardID: map['cardID'] as String,
      theme: map['theme'] as String,
      frontNoteFormat: FrontNoteFormat.values.byName(map['frontNoteFormat']),
      backNoteFormat: BackNoteFormat.values.byName(map['backNoteFormat']),
      frontSideNote:
          map['frontSideNote'] != null ? map['frontSideNote'] as String : null,
      frontSideURL:
          map['frontSideURL'] != null ? map['frontSideURL'] as String : null,
      backSideNote:
          map['backSideNote'] != null ? map['backSideNote'] as String : null,
      backSideURL:
          map['backSideURL'] != null ? map['backSideURL'] as String : null,
      sourceInfo:
          map['sourceInfo'] != null ? map['sourceInfo'] as String : null,
      lastUpdatedTime:
          DateTime.fromMillisecondsSinceEpoch(map['lastUpdatedTime'] as int),
      lastPracticeTime: map['lastPracticeTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastPracticeTime'] as int)
          : null,
      isTrue: map['isTrue'] != null ? map['isTrue'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyCard.fromJson(String source) =>
      MyCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyCard(cardID: $cardID, theme: $theme, frontNoteFormat: $frontNoteFormat, backNoteFormat: $backNoteFormat, frontSideNote: $frontSideNote, frontSideURL: $frontSideURL, backSideNote: $backSideNote, backSideURL: $backSideURL, sourceInfo: $sourceInfo, lastUpdatedTime: $lastUpdatedTime, lastPracticeTime: $lastPracticeTime, isTrue: $isTrue)';
  }

  @override
  bool operator ==(covariant MyCard other) {
    if (identical(this, other)) return true;

    return other.cardID == cardID &&
        other.theme == theme &&
        other.frontNoteFormat == frontNoteFormat &&
        other.backNoteFormat == backNoteFormat &&
        other.frontSideNote == frontSideNote &&
        other.frontSideURL == frontSideURL &&
        other.backSideNote == backSideNote &&
        other.backSideURL == backSideURL &&
        other.sourceInfo == sourceInfo &&
        other.lastUpdatedTime == lastUpdatedTime &&
        other.lastPracticeTime == lastPracticeTime &&
        other.isTrue == isTrue;
  }

  @override
  int get hashCode {
    return cardID.hashCode ^
        theme.hashCode ^
        frontNoteFormat.hashCode ^
        backNoteFormat.hashCode ^
        frontSideNote.hashCode ^
        frontSideURL.hashCode ^
        backSideNote.hashCode ^
        backSideURL.hashCode ^
        sourceInfo.hashCode ^
        lastUpdatedTime.hashCode ^
        lastPracticeTime.hashCode ^
        isTrue.hashCode;
  }
}
