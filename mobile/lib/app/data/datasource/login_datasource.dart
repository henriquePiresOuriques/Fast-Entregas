import 'package:dio/dio.dart';
import 'package:tcc_henrique/app/data/models/profile_model.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/domain/entities/user.dart';

abstract class LoginDatasource {
  Future<Profile> singIn(User user);
}

class LoginDatasouceImpl extends LoginDatasource {
  final Dio dio;

  LoginDatasouceImpl({this.dio});

  @override
  Future<Profile> singIn(User user) async {
    try {
      final response = await dio.post(
        'http://localhost:3333/sessions',
        data: {
          "email": user.email,
          "password": user.password,
        },
      );
      final result = ProfileModel.fromMap(response.data);
      return result;
    } catch (e) {
      throw Exception('Erro ao fazer Login');
    }
  }
}
