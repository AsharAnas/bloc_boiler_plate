import 'package:equatable/equatable.dart';

import 'app_exception.dart';

/// User-facing failure for BLoC/UI.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

final class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

final class ServerFailure extends Failure {
  const ServerFailure(super.message, [this.statusCode]);

  final int? statusCode;

  @override
  List<Object?> get props => [message, statusCode];
}

final class ConnectionFailure extends Failure {
  const ConnectionFailure([super.message = 'No connection. Check your network.']);
}

final class ParseFailure extends Failure {
  const ParseFailure([super.message = 'Invalid response from server.']);
}

final class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong.']);
}

/// Converts [AppException] to [Failure]. Used by [BaseRepository].
Failure exceptionToFailure(AppException e) => switch (e) {
      NetworkException() => NetworkFailure(e.message),
      ServerException() => ServerFailure(e.message, e.statusCode),
      ConnectionException() => ConnectionFailure(e.message),
      ParseException() => ParseFailure(e.message),
      _ => UnknownFailure(e.message),
    };
