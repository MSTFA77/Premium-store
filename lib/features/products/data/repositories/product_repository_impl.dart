import '../../../../core/api_error/api_errors.dart';
import '../../../../core/utils/results.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required ProductRemoteDataSource fakeStoreDataSource,
    required ProductRemoteDataSource dummyJsonDataSource,
  })  : _fakeStoreDataSource = fakeStoreDataSource,
        _dummyJsonDataSource = dummyJsonDataSource;

  final ProductRemoteDataSource _fakeStoreDataSource;
  final ProductRemoteDataSource _dummyJsonDataSource;

  @override
  Future<Result<List<ProductEntity>>> getAllProducts() async {
    Object? lastError;

    Future<List<ProductModel>> safeCall(
      Future<List<ProductModel>> Function() call,
    ) async {
      try {
        return await call();
      } catch (error) {
        // One source failing shouldn't sink the whole screen — keep
        // whatever the other source returns and only surface an error
        // if both fail.
        lastError = error;
        return const <ProductModel>[];
      }
    }

    final responses = await Future.wait([
      safeCall(_fakeStoreDataSource.getProducts),
      safeCall(_dummyJsonDataSource.getProducts),
    ]);

    final merged = [...responses[0], ...responses[1]];

    if (merged.isEmpty) {
      final message = lastError != null
          ? ApiErrorHandler.handle(lastError)
          : 'Unable to load products right now.';
      return ResultFailure(message);
    }

    return Success(merged.map((model) => model.toEntity()).toList());
  }
}
