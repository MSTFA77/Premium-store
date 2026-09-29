import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/cart/presentation/cubit/cart_cubit.dart';
import '../../features/favorites/presentation/cubit/favorites_cubit.dart';
import '../../features/products/data/datasources/product_remote_data_source.dart';
import '../../features/products/data/repositories/product_repository_impl.dart';
import '../../features/products/domain/repositories/product_repository.dart';
import '../../features/products/presentation/cubit/product_cubit.dart';
import '../constants/api_constants.dart';
import '../network/dio_factory.dart';

final GetIt getIt = GetIt.instance;

const String _fakeStoreDioKey = 'fakeStoreDio';
const String _dummyJsonDioKey = 'dummyJsonDio';
const String _fakeStoreDataSourceKey = 'fakeStoreDataSource';
const String _dummyJsonDataSourceKey = 'dummyJsonDataSource';

/// Manual service-locator setup (get_it). Call once, before runApp().
///
/// Kept manual rather than codegen-based (injectable) so the project
/// builds immediately with plain `flutter pub get` — no build_runner
/// step required.
void setupLocator() {
  // Network — one Dio client per API, since each has its own base URL.
  getIt.registerLazySingleton<Dio>(
    () => DioClient.create(ApiConstants.fakeStoreBaseUrl),
    instanceName: _fakeStoreDioKey,
  );
  getIt.registerLazySingleton<Dio>(
    () => DioClient.create(ApiConstants.dummyJsonBaseUrl),
    instanceName: _dummyJsonDioKey,
  );

  // Remote data sources ("api services") — one per source API.
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => FakeStoreRemoteDataSource(getIt<Dio>(instanceName: _fakeStoreDioKey)),
    instanceName: _fakeStoreDataSourceKey,
  );
  getIt.registerLazySingleton<ProductRemoteDataSource>(
    () => DummyJsonRemoteDataSource(getIt<Dio>(instanceName: _dummyJsonDioKey)),
    instanceName: _dummyJsonDataSourceKey,
  );

  // Repository
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      fakeStoreDataSource: getIt<ProductRemoteDataSource>(instanceName: _fakeStoreDataSourceKey),
      dummyJsonDataSource: getIt<ProductRemoteDataSource>(instanceName: _dummyJsonDataSourceKey),
    ),
  );

  // Cubits — a fresh instance per provider, each screen owns its lifecycle.
  getIt.registerFactory<ProductCubit>(() => ProductCubit(getIt()));
  getIt.registerFactory<FavoritesCubit>(() => FavoritesCubit());
  getIt.registerFactory<CartCubit>(() => CartCubit());
}
