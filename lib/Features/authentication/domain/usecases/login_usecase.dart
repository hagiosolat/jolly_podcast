// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/Features/authentication/domain/repositories/auth_repository.dart';
import 'package:jolly_podcast/core/usecases/usecase.dart';
import 'package:jolly_podcast/core/utils/typedef.dart';

class LoginUsecase extends UseCaseWithParams<dynamic, UserLoginParams> {
  const LoginUsecase(this._authRepository);
  final AuthRepository _authRepository;

  @override
  ResultFuture<dynamic> call(UserLoginParams params) => _authRepository.login(
    password: params.passWord,
    phoneNumber: params.phoneNumber,
  );
}

class UserLoginParams extends Equatable {
  final String phoneNumber;
  final String passWord;
  const UserLoginParams({required this.phoneNumber, required this.passWord});

  @override
  List<Object?> get props => [phoneNumber, passWord];
}
