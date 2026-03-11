import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/post.dart';
import '../repositories/post_repository.dart';

class GetPostDetailUseCase implements UseCase<Post, int> {
  final PostRepository repository;

  GetPostDetailUseCase(this.repository);

  @override
  Future<Either<Failure, Post>> call(int id) async {
    return await repository.getPost(id);
  }
}
