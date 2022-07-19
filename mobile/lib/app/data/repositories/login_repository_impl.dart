import 'package:tcc_henrique/app/data/datasource/login_datasource.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/domain/entities/user.dart';
import 'package:dartz/dartz.dart';
import 'package:tcc_henrique/app/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginDatasource loginDatasource;

  LoginRepositoryImpl({this.loginDatasource});

  @override
  Future<Either<Exception, Profile>> singIn(User user) async {
    try {
      final result = await loginDatasource.singIn(user);
      return Right(result);
    } catch (e) {
      return Left(Exception('error'));
    }
  }
}
