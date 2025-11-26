import 'package:fpdart/fpdart.dart';
import 'package:jolly_podcast/core/error/failures.dart';

typedef ResultFuture<T> = Future<Result<T>>;

typedef DataMap = Map<String, dynamic>;

typedef Result<T> = Either<Failures, T>;

