import 'package:fpdart/fpdart.dart';
import 'package:jolly_podcast/Features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:jolly_podcast/Features/authentication/domain/repositories/auth_repository.dart';
import 'package:jolly_podcast/core/error/exceptions.dart';
import 'package:jolly_podcast/core/error/failures.dart';
import 'package:jolly_podcast/core/utils/typedef.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDatasource datasource;
  AuthRepoImpl({required this.datasource});

  @override
  ResultFuture<dynamic> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final result = await datasource.login(
        phoneNumber: phoneNumber,
        password: password,
      );
      return Right(result);
    } on ApiException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
