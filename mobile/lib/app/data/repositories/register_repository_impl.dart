import 'package:tcc_henrique/app/data/datasource/register_datasource.dart';
import 'package:tcc_henrique/app/domain/entities/profile.dart';
import 'package:dartz/dartz.dart';
import 'package:tcc_henrique/app/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl extends RegisterRepository {
  final RegisterDatasouce registerDatasouce;

  RegisterRepositoryImpl({this.registerDatasouce});

  @override
  Future<Either<Exception, Profile>> createAccount(Profile profile) async {
    try {
      final result = await registerDatasouce.createAccount(profile);
      return Right(result);
    } catch (e) {
      return Left(Exception('error'));
    }
  }
}
