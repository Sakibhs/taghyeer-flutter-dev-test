import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Failure for server-related errors
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure for network connectivity errors
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Failure for cache-related errors
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Failure for timeout errors
class TimeoutFailure extends Failure {
  const TimeoutFailure(super.message);
}

/// Failure for empty response/data
class EmptyDataFailure extends Failure {
  const EmptyDataFailure(super.message);
}

/// Failure for pagination errors
class PaginationFailure extends Failure {
  const PaginationFailure(super.message);
}
