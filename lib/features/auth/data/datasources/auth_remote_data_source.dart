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
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        if (response.data == null || response.data.isEmpty) {
          throw EmptyDataException('Server returned empty response');
        }
        return UserModel.fromJson(response.data);
      } else {
        throw ServerException(
          'Login failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException(
          'Connection timeout. Please check your internet connection and try again.',
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(
          'Server is taking too long to respond. Please try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          'No internet connection. Please check your network settings.',
        );
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          throw ServerException('Invalid username or password');
        } else if (statusCode == 403) {
          throw ServerException('Access forbidden. Please contact support.');
        } else if (statusCode == 404) {
          throw ServerException('Service not found. Please try again later.');
        } else if (statusCode == 500) {
          throw ServerException('Server error. Please try again later.');
        } else {
          final message =
              e.response?.data['message'] ?? 'Server error occurred';
          throw ServerException(message);
        }
      } else {
        throw NetworkException('Network error. Please check your connection.');
      }
    } on EmptyDataException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
