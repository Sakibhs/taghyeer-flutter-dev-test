import '../../domain/entities/products_response.dart';
import 'product_model.dart';

class ProductsResponseModel extends ProductsResponse {
  const ProductsResponseModel({
    required super.products,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductsResponseModel(
      products: (json['products'] as List)
          .map((product) => ProductModel.fromJson(product as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      skip: json['skip'] as int,
      limit: json['limit'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((p) => (p as ProductModel).toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}
