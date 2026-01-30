import 'package:dio/dio.dart';

import '../../core/errors/app_exception.dart';
import '../../core/errors/failures.dart';
import '../../core/network/api_result.dart';
import '../../core/network/dio_client.dart';

/// Base for repositories. Wraps API calls and returns [ApiResult<T>].
abstract class BaseRepository {
  /// Runs [action] and returns [ApiSuccess(data)] or [ApiFailure(failure)].
  Future<ApiResult<T>> runCatching<T>(Future<T> Function() action) async {
    try {
      final data = await action();
      return ApiSuccess(data);
    } on DioException catch (e) {
      final failure = exceptionToFailure(DioClient.mapDioException(e));
      return ApiFailure(failure);
    } on AppException catch (e) {
      return ApiFailure(exceptionToFailure(e));
    } catch (e) {
      return ApiFailure(
        exceptionToFailure(UnknownException(e.toString())),
      );
    }
  }
}
