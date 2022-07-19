import 'package:dartz/dartz.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/domain/entities/user.dart';
import 'package:tcc_henrique/app/domain/repositories/login_repository.dart';

abstract class LoginUsecase {
  Future<Either<Exception, Profile>> singIn(User user);
}

class LoginUsecaseImpl extends LoginUsecase {
  final LoginRepository loginRepository;

  LoginUsecaseImpl({this.loginRepository});

  @override
  Future<Either<Exception, Profile>> singIn(User user) {
    return loginRepository.singIn(user);
  }
}
