import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final bool hasReachedMax;
  final int currentSkip;

  const ProductLoaded({
    required this.products,
    required this.hasReachedMax,
    required this.currentSkip,
  });

  ProductLoaded copyWith({
    List<Product>? products,
    bool? hasReachedMax,
    int? currentSkip,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentSkip: currentSkip ?? this.currentSkip,
    );
  }

  @override
  List<Object> get props => [products, hasReachedMax, currentSkip];
}

class ProductLoadingMore extends ProductState {
  final List<Product> products;
  final int currentSkip;

  const ProductLoadingMore({
    required this.products,
    required this.currentSkip,
  });

  @override
  List<Object> get props => [products, currentSkip];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductEmpty extends ProductState {}
