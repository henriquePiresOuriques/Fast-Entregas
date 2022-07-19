import 'package:dio/dio.dart';
import 'package:tcc_henrique/app/data/models/profile_model.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';

abstract class RegisterDatasouce {
  Future<Profile> createAccount(Profile profile);
}

class RegisterDatasourceImpl extends RegisterDatasouce {
  final Dio dio;

  RegisterDatasourceImpl({this.dio});

  @override
  Future<Profile> createAccount(Profile profile) async {
    try {
      final response = await dio.post(
        'http://localhost:3333/users',
        data: {
          "name": profile.name,
          "email": profile.email,
          "password": profile.password,
          "rua": profile.rua,
          "numero": profile.numero,
          "bairro": profile.bairro,
          "complemento": profile.complemento,
          "referencia": profile.referencia,
        },
      );
      final result = ProfileModel.fromMapCrete(response.data);
      return result;
    } catch (e) {
      throw Exception('Erro ao criar conta');
    }
  }
}
