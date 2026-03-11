import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';
import '../models/products_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponseModel> getProducts({required int limit, required int skip});
  Future<ProductModel> getProduct(int id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio dio;
  static const String baseUrl = 'https://dummyjson.com';

  ProductRemoteDataSourceImpl(this.dio);

  @override
  Future<ProductsResponseModel> getProducts({
    required int limit,
    required int skip,
  }) async {
    try {
      final response = await dio.get(
        '$baseUrl/products',
        queryParameters: {
          'limit': limit,
          'skip': skip,
        },
      );

      if (response.statusCode == 200) {
        return ProductsResponseModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to load products');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException('Server timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException('Failed to load products');
      }
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await dio.get('$baseUrl/products/$id');

      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException('Failed to load product');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw ServerException('Server timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException('No internet connection');
      } else {
        throw ServerException('Failed to load product');
      }
    }
  }
}
