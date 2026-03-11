import '../../domain/entities/product.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.title,
    required super.price,
    required super.thumbnail,
    super.description,
    super.category,
    super.rating,
    super.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String,
      description: json['description'] as String?,
      category: json['category'] as String?,
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : null,
      stock: json['stock'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'description': description,
      'category': category,
      'rating': rating,
      'stock': stock,
    };
  }
}
