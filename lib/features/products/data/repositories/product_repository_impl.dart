import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/products_response.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductsResponse>> getProducts({
    required int limit,
    required int skip,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDataSource.getProducts(
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
  Future<Either<Failure, Product>> getProduct(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final product = await remoteDataSource.getProduct(id);
        return Right(product);
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
