import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_product_detail_usecase.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductDetailUseCase getProductDetailUseCase;

  ProductDetailBloc({required this.getProductDetailUseCase})
      : super(ProductDetailInitial()) {
    on<LoadProductDetail>(_onLoadProductDetail);
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());

    final result = await getProductDetailUseCase(event.productId);

    result.fold(
      (failure) => emit(const ProductDetailError('Failed to load product details')),
      (product) => emit(ProductDetailLoaded(product)),
    );
  }
}
