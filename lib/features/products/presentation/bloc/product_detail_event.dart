import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadProductDetail extends ProductDetailEvent {
  final int productId;

  const LoadProductDetail(this.productId);

  @override
  List<Object> get props => [productId];
}
