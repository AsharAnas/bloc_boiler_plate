import 'package:dio/dio.dart';

import 'dio_client.dart';

/// Central HTTP methods. Use in repositories instead of calling Dio directly.
class ApiClient {
  ApiClient._();

  static Dio get _dio => DioClient.dio;

  /// GET request.
  static Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.get<T>(path, queryParameters: queryParameters, options: options);

  /// POST request.
  static Future<Response<T>> post<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options);

  /// PUT request.
  static Future<Response<T>> put<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.put<T>(path, data: data, queryParameters: queryParameters, options: options);

  /// DELETE request.
  static Future<Response<T>> delete<T>(String path, {dynamic data, Map<String, dynamic>? queryParameters, Options? options}) =>
      _dio.delete<T>(path, data: data, queryParameters: queryParameters, options: options);
}
