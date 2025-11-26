import 'package:equatable/equatable.dart';

class ApiException extends Equatable implements Exception {
  const ApiException({required this.message, required this.statusCode});

  final String message;
  final int statusCode;
  @override
  List<Object?> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class NotFoundException extends ApiException {
  const NotFoundException({required super.message, required super.statusCode});
}

class ServerErrorException extends ApiException {
  const ServerErrorException({
    required super.message,
    required super.statusCode,
  });
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({
    required super.message,
    required super.statusCode,
  });
}

class ForbiddenException extends ApiException {
  const ForbiddenException({required super.message, required super.statusCode});
}

class UnknownErrorException extends ApiException {
  const UnknownErrorException({
    required super.message,
    required super.statusCode,
  });
}
