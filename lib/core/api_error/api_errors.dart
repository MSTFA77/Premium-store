import 'package:dio/dio.dart';

class ApiErrorHandler {
  // Static method that takes any error Object and returns a clean, user-friendly error message.
  static String handle(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is Exception) {
      return error.toString().replaceAll('Exception: ', '');
    } else {
      return 'An unexpected error occurred. Please try again later.';
    }
  }

  // Detailed handling for network and Dio-specific failures.
  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Server took too long to respond.';
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return 'Request to the server was cancelled.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network.';
      case DioExceptionType.unknown:
      default:
        return 'Oops! A network error occurred. Please try again.';
    }
  }

  // Handling server response error codes (e.g., 400, 401, 404, 500).
  static String _handleBadResponse(Response? response) {
    if (response == null) return 'Invalid response from the server.';

    final statusCode = response.statusCode;

    // If the server returns a custom error message in the response body.
    if (response.data is Map && response.data['message'] != null) {
      return response.data['message'].toString();
    }

    switch (statusCode) {
      case 400:
        return 'Bad Request. Please check your inputs.';
      case 401:
        return 'Unauthorized. Please log in again.';
      case 403:
        return "Forbidden. You don't have permission to access this resource.";
      case 404:
        return 'Resource not found.';
      case 500:
        return 'Internal Server Error. Please try again later.';
      default:
        return 'Server error occurred. Status code: $statusCode';
    }
  }
}
