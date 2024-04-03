import 'dart:convert';

import 'package:user_repository/src/constants/repo_constants.dart';

class MyUser {
  String id;
  String fullName;
  String email;

  MyUser({
    required this.id,
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({RepoConstants.id: id});
    result.addAll({RepoConstants.fullName: fullName});
    result.addAll({RepoConstants.email: email});

    return result;
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map[RepoConstants.underscoreId] ?? '',
      fullName: map[RepoConstants.fullName] ?? '',
      email: map[RepoConstants.email] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source));

  static MyUser get empty => MyUser(id: '', fullName: '', email: '');

  bool get isNotValid => fullName.isEmpty || email.isEmpty || id.isEmpty;
}
