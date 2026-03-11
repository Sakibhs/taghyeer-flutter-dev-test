import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  static const int _pageSize = 10;

  ProductBloc({required this.getProductsUseCase}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<RefreshProducts>(_onRefreshProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProductsUseCase(
      const GetProductsParams(limit: _pageSize, skip: 0),
    );

    result.fold(
      (failure) => emit(const ProductError('Failed to load products')),
      (response) {
        if (response.products.isEmpty) {
          emit(ProductEmpty());
        } else {
          emit(ProductLoaded(
            products: response.products,
            hasReachedMax: response.products.length >= response.total,
            currentSkip: _pageSize,
          ));
        }
      },
    );
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProducts event,
    Emitter<ProductState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProductLoaded && !currentState.hasReachedMax) {
      emit(ProductLoadingMore(
        products: currentState.products,
        currentSkip: currentState.currentSkip,
      ));

      final result = await getProductsUseCase(
        GetProductsParams(limit: _pageSize, skip: currentState.currentSkip),
      );

      result.fold(
        (failure) => emit(ProductLoaded(
          products: currentState.products,
          hasReachedMax: currentState.hasReachedMax,
          currentSkip: currentState.currentSkip,
        )),
        (response) {
          final allProducts = List.of(currentState.products)
            ..addAll(response.products);
          
          emit(ProductLoaded(
            products: allProducts,
            hasReachedMax: allProducts.length >= response.total,
            currentSkip: currentState.currentSkip + _pageSize,
          ));
        },
      );
    }
  }

  Future<void> _onRefreshProducts(
    RefreshProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());

    final result = await getProductsUseCase(
      const GetProductsParams(limit: _pageSize, skip: 0),
    );

    result.fold(
      (failure) => emit(const ProductError('Failed to refresh products')),
      (response) {
        if (response.products.isEmpty) {
          emit(ProductEmpty());
        } else {
          emit(ProductLoaded(
            products: response.products,
            hasReachedMax: response.products.length >= response.total,
            currentSkip: _pageSize,
          ));
        }
      },
    );
  }
}
