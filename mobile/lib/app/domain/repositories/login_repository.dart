import 'package:dartz/dartz.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/domain/entities/user.dart';

abstract class LoginRepository {
  Future<Either<Exception, Profile>> singIn(User user);
}
