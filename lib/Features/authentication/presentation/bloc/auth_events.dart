part of 'auth_bloc.dart';

sealed class AuthEvents extends Equatable {
  const AuthEvents();
  @override
  List<Object?> get props => [];
}

final class LoginEvent extends AuthEvents {
  const LoginEvent({required this.phoneNumber, required this.passWord});
  final String phoneNumber;
  final String passWord;

  @override
  List<Object?> get props => [phoneNumber, passWord];
}
