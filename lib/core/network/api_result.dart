import '../errors/failures.dart';

/// API outcome: success with [data] or failure with [Failure]. Repos return this; BLoC uses [fold].
sealed class ApiResult<T> {
  const ApiResult();
}

final class ApiSuccess<T> extends ApiResult<T> {
  const ApiSuccess(this.data);
  final T data;
}

final class ApiFailure<T> extends ApiResult<T> {
  const ApiFailure(this.failure);
  final Failure failure;
}

extension ApiResultX<T> on ApiResult<T> {
  T? get dataOrNull => switch (this) {
    ApiSuccess(:final data) => data,
    ApiFailure() => null,
  };
  Failure? get failureOrNull => switch (this) {
    ApiSuccess() => null,
    ApiFailure(failure: final f) => f,
  };

  /// Handle both cases: result.fold((data) => emit(Loaded(data)), (f) => emit(Error(f)))
  R fold<R>(R Function(T) onSuccess, R Function(Failure) onFailure) => switch (this) {
    ApiSuccess(:final data) => onSuccess(data),
    ApiFailure(failure: final f) => onFailure(f),
  };
}
