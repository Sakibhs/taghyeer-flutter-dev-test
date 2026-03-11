import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/posts_response.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PostsResponse>> getPosts({
    required int limit,
    required int skip,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getPosts(
          limit: limit,
          skip: skip,
        );
        return Right(response);
      } on TimeoutException catch (e) {
        return Left(TimeoutFailure(e.message));
      } on EmptyDataException catch (e) {
        return Left(EmptyDataFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: $e'));
      }
    } else {
      return Left(
        NetworkFailure(
          'No internet connection. Please check your network settings.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Post>> getPost(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final post = await remoteDataSource.getPost(id);
        return Right(post);
      } on TimeoutException catch (e) {
        return Left(TimeoutFailure(e.message));
      } on EmptyDataException catch (e) {
        return Left(EmptyDataFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on NetworkException catch (e) {
        return Left(NetworkFailure(e.message));
      } catch (e) {
        return Left(ServerFailure('Unexpected error: $e'));
      }
    } else {
      return Left(
        NetworkFailure(
          'No internet connection. Please check your network settings.',
        ),
      );
    }
  }
}
