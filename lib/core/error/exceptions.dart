/// Base class for all exceptions in the application
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

/// Exception for network connectivity errors
class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

/// Exception for cache-related errors
class CacheException implements Exception {
  final String message;

  CacheException(this.message);
}

/// Exception for validation errors
class ValidationException implements Exception {
  final String message;

  ValidationException(this.message);
}

/// Exception for timeout errors
class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);
}

/// Exception for empty response/data
class EmptyDataException implements Exception {
  final String message;

  EmptyDataException(this.message);
}

/// Exception for pagination errors
class PaginationException implements Exception {
  final String message;

  PaginationException(this.message);
}
