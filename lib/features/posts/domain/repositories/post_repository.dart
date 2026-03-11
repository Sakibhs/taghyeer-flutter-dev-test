import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../entities/posts_response.dart';

abstract class PostRepository {
  Future<Either<Failure, PostsResponse>> getPosts({
    required int limit,
    required int skip,
  });

  Future<Either<Failure, Post>> getPost(int id);
}
