// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Validation {
  String email;
  String validationCode;
  DateTime createdDate;
  DateTime lastValidateDate;
  bool isUsed;
  Validation({
    required this.email,
    required this.validationCode,
    required this.createdDate,
    required this.lastValidateDate,
    required this.isUsed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'validationCode': validationCode,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'lastValidateDate': lastValidateDate.millisecondsSinceEpoch,
      'isUsed': isUsed,
    };
  }

  factory Validation.fromMap(Map<String, dynamic> map) {
    return Validation(
      email: map['email'] as String,
      validationCode: map['validationCode'] as String,
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
      lastValidateDate:
          DateTime.fromMillisecondsSinceEpoch(map['lastValidateDate'] as int),
      isUsed: map['isUsed'] as bool,
    );
  }

  @override
  String toString() {
    return 'Validation(email: $email, validationCode: $validationCode, createdDate: $createdDate, lastValidateDate: $lastValidateDate, isUsed: $isUsed)';
  }
}
