import 'package:dio/dio.dart';

import 'status_code_handler.dart';

/// Auth headers in [onRequest]; error side effects (e.g. 401) via [StatusCodeHandler.onStatusCode].
class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final code = err.response?.statusCode;
    if (code != null) StatusCodeHandler.handleStatusCode(code);
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) => handler.next(response);
}
