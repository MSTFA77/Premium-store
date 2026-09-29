import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../products/domain/entities/product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addProduct(ProductEntity product) {
    final updated = Map<String, CartItemEntity>.from(state.items);
    final existing = updated[product.id];
    updated[product.id] = existing == null
        ? CartItemEntity(product: product, quantity: 1)
        : existing.copyWith(quantity: existing.quantity + 1);
    emit(CartState(items: updated));
  }

  void increaseQuantity(String productId) {
    final existing = state.items[productId];
    if (existing == null) return;
    final updated = Map<String, CartItemEntity>.from(state.items);
    updated[productId] = existing.copyWith(quantity: existing.quantity + 1);
    emit(CartState(items: updated));
  }

  void decreaseQuantity(String productId) {
    final existing = state.items[productId];
    if (existing == null) return;
    final updated = Map<String, CartItemEntity>.from(state.items);
    if (existing.quantity <= 1) {
      updated.remove(productId);
    } else {
      updated[productId] = existing.copyWith(quantity: existing.quantity - 1);
    }
    emit(CartState(items: updated));
  }

  void removeProduct(String productId) {
    final updated = Map<String, CartItemEntity>.from(state.items)..remove(productId);
    emit(CartState(items: updated));
  }

  void clear() => emit(const CartState());
}
