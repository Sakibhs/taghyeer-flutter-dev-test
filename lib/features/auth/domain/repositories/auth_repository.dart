import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user.dart';

/// Repository contract for authentication
abstract class AuthRepository {
  /// Login with username and password
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
    int expiresInMins = 30,
  });

  /// Logout the current user
  Future<Either<Failure, void>> logout();

  /// Check authentication status (auto-login)
  Future<Either<Failure, User?>> checkAuthStatus();
}
