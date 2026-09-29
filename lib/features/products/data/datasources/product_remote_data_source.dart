import 'package:dio/dio.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/product_model.dart';

/// Contract for anything that can fetch a raw list of products.
/// Two concrete implementations below, one per source API — this is
/// the "api_services" layer the repository depends on.
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class FakeStoreRemoteDataSource implements ProductRemoteDataSource {
  FakeStoreRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get<List<dynamic>>(ApiConstants.productsPath);
    final data = response.data ?? const [];
    return data
        .map((json) => ProductModel.fromFakeStore(json as Map<String, dynamic>))
        .toList();
  }
}

class DummyJsonRemoteDataSource implements ProductRemoteDataSource {
  DummyJsonRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get<Map<String, dynamic>>(ApiConstants.productsPath);
    final list = (response.data?['products'] as List<dynamic>?) ?? const [];
    return list
        .map((json) => ProductModel.fromDummyJson(json as Map<String, dynamic>))
        .toList();
  }
}
