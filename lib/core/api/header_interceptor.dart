import 'package:dio/dio.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final box = await Hive.openBox("jolly_Podcast");
    final authToken = box.get("authToken") as String?;
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = "Bearer $authToken";
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {}
    super.onError(err, handler);
  }
}
