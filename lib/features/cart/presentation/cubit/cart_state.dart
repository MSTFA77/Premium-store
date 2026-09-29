import 'package:equatable/equatable.dart';

import '../../domain/entities/cart_item_entity.dart';

class CartState extends Equatable {
  const CartState({this.items = const {}});

  final Map<String, CartItemEntity> items;

  List<CartItemEntity> get cartItems => items.values.toList();

  int get itemCount => items.values.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice => items.values.fold(0.0, (sum, item) => sum + item.totalPrice);

  @override
  List<Object?> get props => [items];
}
