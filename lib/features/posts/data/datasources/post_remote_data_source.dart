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
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return PostsResponseModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to load posts');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException('Server timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException('Failed to load posts');
      }
    }
  }

  @override
  Future<PostModel> getPost(int id) async {
    try {
      final response = await dio.get('$baseUrl/posts/$id');

      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to load post');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException('Server timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException('Failed to load post');
      }
    }
  }
}
