import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/login_request_model.dart';
import '../models/user_model.dart';

/// Contract for authentication remote data source
abstract class AuthRemoteDataSource {
  /// Login with username and password
  Future<UserModel> login(LoginRequestModel request);
}

/// Implementation of AuthRemoteDataSource using Dio
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'https://dummyjson.com';

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login(LoginRequestModel request) async {
    try {
      final response = await dio.post(
        '$baseUrl/auth/login',
        data: request.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException('Login failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw NetworkException('Connection timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else if (e.response != null) {
        final message = e.response?.data['message'] ?? 'Server error';
        throw ServerException(message);
      } else {
        throw ServerException('Unexpected error occurred');
      }
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
