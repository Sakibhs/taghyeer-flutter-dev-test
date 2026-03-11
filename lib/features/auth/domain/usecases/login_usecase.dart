import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

/// Use case for user login
class LoginUseCase implements UseCase<User, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await repository.login(
      username: params.username,
      password: params.password,
      expiresInMins: params.expiresInMins,
    );
  }
}

/// Parameters for login use case
class LoginParams extends Equatable {
  final String username;
  final String password;
  final int expiresInMins;

  const LoginParams({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });

  @override
  List<Object> get props => [username, password, expiresInMins];
}
