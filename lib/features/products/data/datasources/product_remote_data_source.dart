import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';
import '../models/products_response_model.dart';

abstract class ProductRemoteDataSource {
  Future<ProductsResponseModel> getProducts({
    required int limit,
    required int skip,
  });
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
        queryParameters: {'limit': limit, 'skip': skip},
      );

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw EmptyDataException('Server returned empty response');
        }
        final result = ProductsResponseModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        return result;
      } else {
        throw ServerException(
          'Failed to load products with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(
          'Server is taking too long to respond. Please try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          'No internet connection. Please check your network.',
        );
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          throw ServerException('Products not found');
        } else if (statusCode == 500) {
          throw ServerException('Server error. Please try again later.');
        } else {
          throw ServerException('Failed to load products');
        }
      } else {
        throw NetworkException('Network error occurred');
      }
    } on EmptyDataException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await dio.get('$baseUrl/products/$id');

      if (response.statusCode == 200) {
        if (response.data == null) {
          throw EmptyDataException('Product data not found');
        }
        return ProductModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw ServerException(
          'Failed to load product with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw TimeoutException('Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw TimeoutException(
          'Server is taking too long to respond. Please try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        throw NetworkException(
          'No internet connection. Please check your network.',
        );
      } else if (e.response != null) {
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          throw ServerException('Product not found');
        } else if (statusCode == 500) {
          throw ServerException('Server error. Please try again later.');
        } else {
          throw ServerException('Failed to load product');
        }
      } else {
        throw NetworkException('Network error occurred');
      }
    } on EmptyDataException {
      rethrow;
    } on TimeoutException {
      rethrow;
    } catch (e) {
      throw ServerException('Unexpected error: $e');
    }
  }
}
