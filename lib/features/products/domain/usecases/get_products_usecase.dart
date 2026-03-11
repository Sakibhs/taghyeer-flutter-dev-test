import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/products_response.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase implements UseCase<ProductsResponse, GetProductsParams> {
  final ProductRepository repository;

  GetProductsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductsResponse>> call(GetProductsParams params) async {
    return await repository.getProducts(
      limit: params.limit,
      skip: params.skip,
    );
  }
}

class GetProductsParams {
  final int limit;
  final int skip;

  const GetProductsParams({
    required this.limit,
    required this.skip,
  });
}
