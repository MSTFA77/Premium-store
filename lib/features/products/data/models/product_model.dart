import '../../domain/entities/product_entity.dart';

/// Data-layer representation of a product. Two factories map the two
/// different API response shapes into this one model; [toEntity] then
/// hands a clean, source-agnostic object up to the domain layer.
class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPercentage,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.source,
  });

  final String id;
  final String title;
  final String description;
  final double price;
  final double discountPercentage;
  final String category;
  final String imageUrl;
  final double rating;
  final ProductSource source;

  /// https://fakestoreapi.com/products
  factory ProductModel.fromFakeStore(Map<String, dynamic> json) {
    final ratingMap = json['rating'] as Map<String, dynamic>?;
    return ProductModel(
      // Prefixed so ids stay unique once merged with the other source.
      id: 'fs_${json['id']}',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      discountPercentage: 0,
      category: json['category'] as String? ?? 'general',
      imageUrl: json['image'] as String? ?? '',
      rating: (ratingMap?['rate'] as num?)?.toDouble() ?? 0,
      source: ProductSource.fakeStore,
    );
  }

  /// https://dummyjson.com/products
  factory ProductModel.fromDummyJson(Map<String, dynamic> json) {
    final images = json['images'] as List<dynamic>?;
    final thumbnail = json['thumbnail'] as String?;
    return ProductModel(
      id: 'dj_${json['id']}',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
      category: json['category'] as String? ?? 'general',
      imageUrl: thumbnail ??
          (images != null && images.isNotEmpty ? images.first as String : ''),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      source: ProductSource.dummyJson,
    );
  }

  ProductEntity toEntity() => ProductEntity(
        id: id,
        title: title,
        description: description,
        price: price,
        discountPercentage: discountPercentage,
        category: category,
        imageUrl: imageUrl,
        rating: rating,
        source: source,
      );
}
