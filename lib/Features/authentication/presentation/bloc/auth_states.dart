part of 'auth_bloc.dart';

final class AuthStates extends Equatable {
  const AuthStates({
    this.status = LoginStatus.initial,
    this.userData,
    this.errorMessage = '',
  });

  final LoginStatus status;
  final dynamic userData;
  final String errorMessage;

  AuthStates copyWith({
    LoginStatus? status,
    dynamic userData,
    String? errorMessage,
  }) => AuthStates(
    status: status ?? this.status,
    userData: userData ?? this.userData,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [status, userData, errorMessage];
}
