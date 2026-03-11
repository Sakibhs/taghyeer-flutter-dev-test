import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductDetailUseCase implements UseCase<Product, int> {
  final ProductRepository repository;

  GetProductDetailUseCase(this.repository);

  @override
  Future<Either<Failure, Product>> call(int id) async {
    return await repository.getProduct(id);
  }
}
