import 'package:jolly_podcast/core/utils/typedef.dart';

abstract class AuthRepository {
  ResultFuture<dynamic> login({required String phoneNumber, required String password});
}
