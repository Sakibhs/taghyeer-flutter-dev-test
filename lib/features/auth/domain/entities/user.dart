import 'package:equatable/equatable.dart';

/// User entity representing the domain model
class User extends Equatable {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String token;
  final String refreshToken;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
    required this.refreshToken,
  });

  @override
  List<Object> get props => [
        id,
        username,
        email,
        firstName,
        lastName,
        gender,
        image,
        token,
        refreshToken,
      ];
}
