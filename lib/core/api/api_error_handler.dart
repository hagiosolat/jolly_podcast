import 'package:dio/dio.dart';
import 'package:jolly_podcast/core/error/exceptions.dart';

class ErrorHandler {
  static dynamic handleDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        throw ApiException(
          message: 'Request to API server was cancelled',
          statusCode: 600,
        );
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        throw ApiException(
          message: "Connection timeout with API server",
          statusCode: 600,
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(
          dioError.response?.statusCode,
          dioError.response?.data["message"],
        );
      default:
        throw ApiException(message: "Something went wrong", statusCode: 600);
    }
  }

  static dynamic _handleBadResponse(int? statusCode, dynamic errorMessage) {
    switch (statusCode) {
      case 400:
      case 401:
      case 422:
        throw UnauthorizedException(
          message: errorMessage,
          statusCode: statusCode ?? 500,
        );
      case 403:
        throw ForbiddenException(
          message: errorMessage,
          statusCode: statusCode ?? 500,
        );
      case 404:
        throw NotFoundException(
          message: errorMessage,
          statusCode: statusCode ?? 500,
        );
      case 500:
        throw ServerErrorException(
          message: errorMessage,
          statusCode: statusCode ?? 500,
        );
      default:
        throw ApiException(message: "unknown Error", statusCode: 600);
    }
  }
}
