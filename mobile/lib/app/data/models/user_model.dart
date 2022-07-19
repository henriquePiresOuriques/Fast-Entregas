import 'dart:convert';

import 'package:tcc_henrique/app/domain/entities/user.dart';

class UserModel implements User {
  @override
  final String email;
  @override
  final String password;

  UserModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
