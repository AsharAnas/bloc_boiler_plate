/// Base exception for the app. Use subclasses for specific error types.
sealed class AppException implements Exception {
  const AppException(this.message, [this.statusCode]);

  final String message;
  final int? statusCode;

  @override
  String toString() => 'AppException: $message';
}

/// Thrown when a network/API request fails.
final class NetworkException extends AppException {
  const NetworkException(super.message, [super.statusCode]);
}

/// Thrown when the server returns an error (4xx, 5xx).
final class ServerException extends AppException {
  const ServerException(super.message, [super.statusCode]);
}

/// Thrown when request times out or no connectivity.
final class ConnectionException extends AppException {
  const ConnectionException([super.message = 'Connection failed']);
}

/// Thrown when response cannot be parsed (e.g. invalid JSON).
final class ParseException extends AppException {
  const ParseException([super.message = 'Failed to parse response']);
}

/// Thrown for unknown/unexpected errors.
final class UnknownException extends AppException {
  const UnknownException([super.message = 'Something went wrong']);
}
