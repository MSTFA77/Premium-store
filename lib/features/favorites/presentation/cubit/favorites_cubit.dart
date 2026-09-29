import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/domain/entities/product_entity.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  void toggle(ProductEntity product) {
    final updated = Map<String, ProductEntity>.from(state.items);
    if (updated.containsKey(product.id)) {
      updated.remove(product.id);
    } else {
      updated[product.id] = product;
    }
    emit(FavoritesState(items: updated));
  }

  void remove(String productId) {
    final updated = Map<String, ProductEntity>.from(state.items)..remove(productId);
    emit(FavoritesState(items: updated));
  }
}
