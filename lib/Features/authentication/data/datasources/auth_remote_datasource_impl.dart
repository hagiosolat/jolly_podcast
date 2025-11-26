import 'package:dio/dio.dart';
import 'package:jolly_podcast/Features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:jolly_podcast/core/api/api_client.dart';
import 'package:jolly_podcast/core/api/api_error_handler.dart';
import 'package:jolly_podcast/core/error/exceptions.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  const AuthRemoteDatasourceImpl({required this.apiclient});
  final ApiClient apiclient;
  @override
  Future<dynamic> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await apiclient.post(
        'auth/login',
        requestBody: {'phone_number': phoneNumber, 'password': password},
      );
      return response.data;
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 700);
    }
  }
}
