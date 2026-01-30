import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../errors/app_exception.dart';
import 'api_interceptor.dart';
import 'status_code_handler.dart';

/// Singleton Dio client. Use [ApiClient] in repos; [mapDioException] used by [BaseRepository].
class DioClient {
  DioClient._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      ),
    );
    _dio.interceptors.addAll([ApiInterceptor(), LogInterceptor(requestBody: true, responseBody: true)]);
  }

  static final DioClient _instance = DioClient._();
  late final Dio _dio;

  static Dio get dio => _instance._dio;

  static AppException mapDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ConnectionException('Request timed out');
      case DioExceptionType.connectionError:
        return const ConnectionException('No internet connection');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = _extractMessage(e.response) ?? StatusCodeHandler.messageFor(statusCode);
        return ServerException(message, statusCode);
      case DioExceptionType.cancel:
        return const NetworkException('Request cancelled');
      case DioExceptionType.badCertificate:
        return const ConnectionException('Invalid certificate');
      case DioExceptionType.unknown:
        return UnknownException(e.message ?? 'Unknown error');
    }
  }

  static String? _extractMessage(Response? response) {
    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      return data['message'] as String? ?? data['error'] as String?;
    }
    if (response?.data is String) return response!.data as String;
    return null;
  }
}
