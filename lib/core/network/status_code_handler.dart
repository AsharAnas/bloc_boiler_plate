/// Status code → default message (when API returns none). [onStatusCode] for 401 etc.
class StatusCodeHandler {
  StatusCodeHandler._();

  static String messageFor(int? code) {
    if (code == null) return 'Something went wrong';
    return switch (code) {
      400 => 'Bad request',
      401 => 'Unauthorized. Please sign in again.',
      403 => 'You don\'t have permission to do this.',
      404 => 'Not found',
      408 => 'Request timed out',
      409 => 'Conflict with current state',
      422 => 'Invalid data',
      429 => 'Too many requests. Try again later.',
      500 => 'Server error. Try again later.',
      502 => 'Server temporarily unavailable',
      503 => 'Service unavailable. Try again later.',
      _ => code >= 500 ? 'Server error. Try again later.' : 'Request failed ($code)',
    };
  }

  /// Set in main() to run side effects on error (e.g. 401 → clear token).
  static void Function(int statusCode)? onStatusCode;

  static void handleStatusCode(int statusCode) => onStatusCode?.call(statusCode);
}
