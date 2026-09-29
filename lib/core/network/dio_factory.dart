import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

/// Builds a preconfigured [Dio] client for a given base URL.
/// Each remote API gets its own instance since their base URLs differ.
class DioClient {
  const DioClient._();

  static Dio create(String baseUrl) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: const {'Content-Type': 'application/json'},
      ),
    );
  }
}
