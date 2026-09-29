import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/results.dart';
import '../../domain/repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._repository) : super(const ProductState());

  final ProductRepository _repository;

  Future<void> loadProducts() async {
    emit(state.copyWith(status: ProductStatus.loading));
    final result = await _repository.getAllProducts();
    switch (result) {
      case Success(data: final products):
        emit(state.copyWith(status: ProductStatus.loaded, allProducts: products));
      case ResultFailure(message: final msg):
        emit(state.copyWith(status: ProductStatus.error, errorMessage: msg));
    }
  }

  void search(String query) => emit(state.copyWith(searchQuery: query));

  void filterByCategory(String? category) {
    if (category == null) {
      emit(state.copyWith(clearCategory: true));
    } else {
      emit(state.copyWith(selectedCategory: category));
    }
  }
}
