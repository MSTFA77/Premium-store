import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product_entity.dart';

class FavoritesState extends Equatable {
  const FavoritesState({this.items = const {}});

  final Map<String, ProductEntity> items;

  bool isFavorite(String productId) => items.containsKey(productId);

  List<ProductEntity> get favoriteProducts => items.values.toList();

  @override
  List<Object?> get props => [items];
}
