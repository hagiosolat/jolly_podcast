abstract class AuthRemoteDatasource {
  Future<dynamic> login({
    required String phoneNumber,
    required String password,
  });
}
