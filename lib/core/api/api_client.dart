import 'package:dio/dio.dart';
import 'package:jolly_podcast/core/api/env.dart';
import 'package:jolly_podcast/core/api/header_interceptor.dart';

class ApiClient {
  late final Dio _dio;
  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: headers,
      ),
    );
    _dio.interceptors.add(CustomInterceptor());
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.get(
      path,
      queryParameters: params,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> post(
    String path, {
    dynamic requestBody,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.post(
      path,
      queryParameters: queryParameters,
      data: requestBody,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
      onSendProgress: onSendProgress,
    );
  }
}

Map<String, dynamic> headers = {
  contentType: applicationJson,
  accept: applicationJson,
};

const String applicationJson = "application/json";
const String contentType = "content-type";
const String accept = "accept";
