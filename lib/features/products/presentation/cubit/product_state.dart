import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductState extends Equatable {
  const ProductState({
    this.status = ProductStatus.initial,
    this.allProducts = const [],
    this.searchQuery = '',
    this.selectedCategory,
    this.errorMessage,
  });

  final ProductStatus status;
  final List<ProductEntity> allProducts;
  final String searchQuery;
  final String? selectedCategory;
  final String? errorMessage;

  List<String> get categories {
    final set = allProducts.map((p) => p.category).toSet().toList();
    set.sort();
    return set;
  }

  List<ProductEntity> get visibleProducts {
    return allProducts.where((product) {
      final matchesCategory =
          selectedCategory == null || product.category == selectedCategory;
      final matchesSearch = searchQuery.isEmpty ||
          product.title.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  ProductState copyWith({
    ProductStatus? status,
    List<ProductEntity>? allProducts,
    String? searchQuery,
    String? selectedCategory,
    bool clearCategory = false,
    String? errorMessage,
  }) {
    return ProductState(
      status: status ?? this.status,
      allProducts: allProducts ?? this.allProducts,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedCategory:
          clearCategory ? null : (selectedCategory ?? this.selectedCategory),
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, allProducts, searchQuery, selectedCategory, errorMessage];
}
