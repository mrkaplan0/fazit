// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Fach { fisi, fiae, kauf }

class MyUser {
  final String userID;
  String? username;
  String email;
  String? profilURL;
  DateTime createdDate;
  DateTime validationDate;
  bool isTeacher;
  bool isAdmin;
  Enum? branch;

  MyUser({
    required this.userID,
    this.username,
    required this.email,
    this.profilURL,
    required this.createdDate,
    required this.validationDate,
    required this.isTeacher,
    required this.isAdmin,
    required this.branch,
  });

  MyUser copyWith({
    String? userID,
    String? username,
    String? email,
    String? profilURL,
    DateTime? createdDate,
    DateTime? validationDate,
    bool? isTeacher,
    bool? isAdmin,
    Enum? branch,
  }) {
    return MyUser(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      email: email ?? this.email,
      profilURL: profilURL ?? this.profilURL,
      createdDate: createdDate ?? this.createdDate,
      validationDate: validationDate ?? this.validationDate,
      isTeacher: isTeacher ?? this.isTeacher,
      isAdmin: isAdmin ?? this.isAdmin,
      branch: branch ?? this.branch,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userID': userID,
      'username': username,
      'email': email,
      'profilURL': profilURL,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'validationDate': validationDate.millisecondsSinceEpoch,
      'isTeacher': isTeacher,
      'isAdmin': isAdmin,
      'branch': branch.toString(),
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      userID: map['userID'] as String,
      username: map['username'] != null ? map['username'] as String : null,
      email: map['email'] as String,
      profilURL: map['profilURL'] != null ? map['profilURL'] as String : null,
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
      validationDate:
          DateTime.fromMillisecondsSinceEpoch(map['validationDate'] as int),
      isTeacher: map['isTeacher'] as bool,
      isAdmin: map['isAdmin'] as bool,
      branch: map['branch'] != null ? map['branch'] as Fach : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) =>
      MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MyUser(userID: $userID, username: $username, email: $email, profilURL: $profilURL, createdDate: $createdDate, validationDate: $validationDate, isTeacher: $isTeacher, isAdmin: $isAdmin, branch: $branch)';
  }

  @override
  bool operator ==(covariant MyUser other) {
    if (identical(this, other)) return true;

    return other.userID == userID &&
        other.username == username &&
        other.email == email &&
        other.profilURL == profilURL &&
        other.createdDate == createdDate &&
        other.validationDate == validationDate &&
        other.isTeacher == isTeacher &&
        other.isAdmin == isAdmin &&
        other.branch == branch;
  }

  @override
  int get hashCode {
    return userID.hashCode ^
        username.hashCode ^
        email.hashCode ^
        profilURL.hashCode ^
        createdDate.hashCode ^
        validationDate.hashCode ^
        isTeacher.hashCode ^
        isAdmin.hashCode ^
        branch.hashCode;
  }
}
