import 'dart:convert';

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
  
    result.addAll({'id': id});
    result.addAll({'fullName': fullName});
    result.addAll({'email': email});
  
    return result;
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['_id'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source));

  static MyUser get empty => MyUser(id: '', fullName: '', email: '');

  bool get isNotValid => fullName.isEmpty || email.isEmpty || id.isEmpty;
}
