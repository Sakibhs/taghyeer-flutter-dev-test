import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/post_model.dart';
import '../models/posts_response_model.dart';

abstract class PostRemoteDataSource {
  Future<PostsResponseModel> getPosts({required int limit, required int skip});
  Future<PostModel> getPost(int id);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'https://dummyjson.com';

  PostRemoteDataSourceImpl(this.dio);

  @override
  Future<PostsResponseModel> getPosts({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl/posts',
        queryParameters: {'limit': limit, 'skip': skip},
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw EmptyDataException('Server returned empty response');
        }
        return PostsResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      } else {
        throw ServerException(
          'Failed to load posts with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(
          'Server is taking too long to respond. Please try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          'No internet connection. Please check your network.',
        );
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          throw ServerException('Posts not found');
        } else if (statusCode == 500) {
          throw ServerException('Server error. Please try again later.');
        } else {
          throw ServerException('Failed to load posts');
        }
      } else {
        throw NetworkException('Network error occurred');
      }
    } on EmptyDataException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<PostModel> getPost(int id) async {
    try {
      final response = await dio.get('$baseUrl/posts/$id');

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw EmptyDataException('Post data not found');
        }
        return PostModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          'Failed to load post with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(
          'Server is taking too long to respond. Please try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          'No internet connection. Please check your network.',
        );
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          throw ServerException('Post not found');
        } else if (statusCode == 500) {
          throw ServerException('Server error. Please try again later.');
        } else {
          throw ServerException('Failed to load post');
        }
      } else {
        throw NetworkException('Network error occurred');
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
