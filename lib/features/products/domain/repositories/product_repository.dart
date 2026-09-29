import '../../../../core/utils/results.dart';
import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<Result<List<ProductEntity>>> getAllProducts();
}
