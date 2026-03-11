import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {
  const LoadProducts();
}

class LoadMoreProducts extends ProductEvent {
  const LoadMoreProducts();
}

class RefreshProducts extends ProductEvent {
  const RefreshProducts();
}
