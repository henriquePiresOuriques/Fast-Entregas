import 'package:dartz/dartz.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:tcc_henrique/app/domain/repositories/register_repository.dart';

abstract class RegisterUsecase {
  Future<Either<Exception, Profile>> createAccount(Profile profile);
}

class RegisterUsecaseImpl extends RegisterUsecase {
  final RegisterRepository registerRepository;

  RegisterUsecaseImpl({this.registerRepository});

  @override
  Future<Either<Exception, Profile>> createAccount(Profile profile) {
    return registerRepository.createAccount(profile);
  }
}
