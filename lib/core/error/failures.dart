import 'package:equatable/equatable.dart';
import 'package:jolly_podcast/core/error/exceptions.dart';

abstract class Failures extends Equatable {
  const Failures({required this.message, required this.statusCode});
  final String? message;
  final dynamic statusCode;

  String get errorMessage =>
      "$statusCode"
      "${statusCode is String ? '' : 'Error'} $message";

  @override
  List<Object?> get props => [message, statusCode];
}

class APIFailure extends Failures {
  const APIFailure({required super.message, required super.statusCode});

  factory APIFailure.fromException(ApiException exception) {
    return APIFailure(
      message: exception.message,
      statusCode: exception.statusCode,
    );
  }
}

class CacheFailure extends Failures {
  const CacheFailure({required super.message, required super.statusCode});
}
