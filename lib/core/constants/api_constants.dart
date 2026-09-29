class ApiConstants {
  const ApiConstants._();

  static const String fakeStoreBaseUrl = 'https://fakestoreapi.com';
  static const String dummyJsonBaseUrl = 'https://dummyjson.com';

  static const String productsPath = '/products';

  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
