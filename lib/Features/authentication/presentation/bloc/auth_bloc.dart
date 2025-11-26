import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:jolly_podcast/Features/authentication/domain/usecases/login_usecase.dart';
import 'package:jolly_podcast/core/enum/global_enum.dart';
part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  AuthBloc({required LoginUsecase login})
    : _login = login,
      super(AuthStates()) {
    on<LoginEvent>(_loginEventHandler);
  }
  final LoginUsecase _login;
  Future<void> _loginEventHandler(
    LoginEvent event,
    Emitter<AuthStates> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));
    final result = await _login(
      UserLoginParams(phoneNumber: event.phoneNumber, passWord: event.passWord),
    );
    result.fold(
      (error) => emit(
        state.copyWith(
          status: LoginStatus.failure,
          errorMessage: error.message,
        ),
      ),
      (response) {
        storeToken(response["data"]["token"]);
        emit(state.copyWith(status: LoginStatus.success, userData: response));
      },
    );
  }
}

void storeToken(String authToken) async {
  final box = await Hive.openBox("jolly_Podcast");
  box.put("authToken", authToken);
}
