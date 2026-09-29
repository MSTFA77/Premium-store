import 'package:equatable/equatable.dart';

/// Which remote API a product came from. The two source APIs return
/// different shapes; the repository maps both into this single entity.
enum ProductSource { fakeStore, dummyJson }

class ProductEntity extends Equatable {
  const ProductEntity({
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

  bool get hasDiscount => discountPercentage > 0;

  /// The pre-discount price, derived from [price] and [discountPercentage].
  double get originalPrice =>
      hasDiscount ? price / (1 - (discountPercentage / 100)) : price;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        discountPercentage,
        category,
        imageUrl,
        rating,
        source,
      ];
}
