import 'package:equatable/equatable.dart';

/// Base class for all authentication events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Event to check authentication status (auto-login)
class AuthStatusChecked extends AuthEvent {
  const AuthStatusChecked();
}

/// Event for user login
class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  const LoginRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object> get props => [username, password];
}

/// Event for user logout
class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

/// Event to reset auth state
class AuthReset extends AuthEvent {
  const AuthReset();
}
