import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/posts_response.dart';
import '../repositories/post_repository.dart';

class GetPostsUseCase implements UseCase<PostsResponse, GetPostsParams> {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  @override
  Future<Either<Failure, PostsResponse>> call(GetPostsParams params) async {
    return await repository.getPosts(
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class GetPostsParams {
  final int limit;
  final int skip;

  const GetPostsParams({
    required this.limit,
    required this.skip,
  });
}
