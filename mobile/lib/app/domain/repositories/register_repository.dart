import 'package:dartz/dartz.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';

abstract class RegisterRepository {
  Future<Either<Exception, Profile>> createAccount(Profile profile);
}
