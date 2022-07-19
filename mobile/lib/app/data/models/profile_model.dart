import 'dart:convert';

import 'package:tcc_henrique/app/domain/entities/profile.dart';

class ProfileModel implements Profile {
  @override
  final String id;
  @override
  final String name;
  @override
  final String email;
  @override
  final String rua;
  @override
  final String numero;
  @override
  final String bairro;
  @override
  final String complemento;
  @override
  final String referencia;
  @override
  final String password;

  ProfileModel({
    this.id,
    this.name,
    this.email,
    this.rua,
    this.numero,
    this.bairro,
    this.complemento,
    this.referencia,
    this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'rua': rua,
      'numero': numero,
      'bairro': bairro,
      'complemento': complemento,
      'referencia': referencia,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['user']['id'] ?? '',
      name: map['user']['name'] ?? '',
      email: map['user']['email'] ?? '',
      rua: map['user']['rua'] ?? '',
      numero: map['user']['numero'] ?? '',
      bairro: map['user']['bairro'] ?? '',
      complemento: map['user']['complemento'] ?? '',
      referencia: map['user']['referencia'] ?? '',
    );
  }
  factory ProfileModel.fromMapCrete(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      rua: map['rua'] ?? '',
      numero: map['numero'] ?? '',
      bairro: map['bairro'] ?? '',
      complemento: map['complemento'] ?? '',
      referencia: map['referencia'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));
}
