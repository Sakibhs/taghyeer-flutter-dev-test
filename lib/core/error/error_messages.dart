import 'failures.dart';

/// Utility class for converting failures to user-friendly messages
class ErrorMessages {
  /// Get a user-friendly error message from a Failure
  static String getErrorMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return _getNetworkErrorMessage(failure.message);
    } else if (failure is TimeoutFailure) {
      return _getTimeoutErrorMessage(failure.message);
    } else if (failure is ServerFailure) {
      return _getServerErrorMessage(failure.message);
    } else if (failure is EmptyDataFailure) {
      return 'No data available at the moment. Please try again later.';
    } else if (failure is CacheFailure) {
      return 'Unable to load cached data. Please try again.';
    } else if (failure is PaginationFailure) {
      return 'Failed to load more items. Please try again.';
    } else if (failure is ValidationFailure) {
      return failure.message;
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  static String _getNetworkErrorMessage(String message) {
    if (message.toLowerCase().contains('no internet') ||
        message.toLowerCase().contains('network')) {
      return '📡 No internet connection\nPlease check your network settings and try again.';
    }
    return '📡 Network error\n$message';
  }

  static String _getTimeoutErrorMessage(String message) {
    if (message.toLowerCase().contains('connection timeout')) {
      return '⏱️ Connection timeout\nThe server is taking too long to respond. Please check your connection and try again.';
    } else if (message.toLowerCase().contains('slow') ||
        message.toLowerCase().contains('taking too long')) {
      return '⏱️ Slow response\nThe server is responding slowly. Please wait a moment and try again.';
    }
    return '⏱️ Request timeout\n$message';
  }

  static String _getServerErrorMessage(String message) {
    if (message.toLowerCase().contains('500')) {
      return '🔧 Server error\nThe server is experiencing issues. Please try again later.';
    } else if (message.toLowerCase().contains('404') ||
        message.toLowerCase().contains('not found')) {
      return '🔍 Not found\nThe requested resource was not found.';
    } else if (message.toLowerCase().contains('401') ||
        message.toLowerCase().contains('unauthorized')) {
      return '🔐 Authentication failed\nInvalid credentials. Please check your username and password.';
    } else if (message.toLowerCase().contains('403') ||
        message.toLowerCase().contains('forbidden')) {
      return '🚫 Access denied\nYou don\'t have permission to access this resource.';
    }
    return '❌ Server error\n$message';
  }

  /// Get a short error message suitable for snackbars
  static String getShortErrorMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return 'No internet connection';
    } else if (failure is TimeoutFailure) {
      return 'Request timeout. Please try again.';
    } else if (failure is ServerFailure) {
      if (failure.message.toLowerCase().contains('500')) {
        return 'Server error occurred';
      } else if (failure.message.toLowerCase().contains('404')) {
        return 'Resource not found';
      }
      return 'Server error';
    } else if (failure is EmptyDataFailure) {
      return 'No data available';
    } else if (failure is PaginationFailure) {
      return 'Failed to load more items';
    }
    return failure.message;
  }
}
