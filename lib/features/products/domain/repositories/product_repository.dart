import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/product.dart';
import '../entities/products_response.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductsResponse>> getProducts({
    required int limit,
    required int skip,
  });
  
  Future<Either<Failure, Product>> getProduct(int id);
}
