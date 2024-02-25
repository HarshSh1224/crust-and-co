import 'dart:convert';

import 'package:user_repository/constants/user_constants.dart';

class MyUser {
  String userId;
  String? avatar;
  String email;
  String name;
  bool hasActiveCart;

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
    this.avatar,
  });

  static final empty = MyUser(userId: '', email: '', name: '', hasActiveCart: false);

  Map<String, dynamic> toMap() {
    return {
      UserConstants.userId: userId,
      UserConstants.avatar: avatar,
      UserConstants.email: email,
      UserConstants.name: name,
      UserConstants.hasActiveCart: hasActiveCart,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> json) {
    return MyUser(
      userId: json[UserConstants.userId] ?? '',
      avatar: json[UserConstants.avatar],
      email: json[UserConstants.email] ?? '',
      name: json[UserConstants.name] ?? '',
      hasActiveCart: json[UserConstants.hasActiveCart] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source));
}
