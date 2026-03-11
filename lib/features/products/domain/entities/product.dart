import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String? description;
  final String? category;
  final double? rating;
  final int? stock;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.thumbnail,
    this.description,
    this.category,
    this.rating,
    this.stock,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        thumbnail,
        description,
        category,
        rating,
        stock,
      ];
}
