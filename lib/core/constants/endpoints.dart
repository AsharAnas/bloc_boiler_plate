/// All API paths in one place. Add new endpoints here.
class Endpoints {
  Endpoints._();

  // Posts
  static const String posts = '/posts';
  static String postById(int id) => '/posts/$id';

  // Users
  static const String users = '/users';
  static String userById(int id) => '/users/$id';

  // Auth (test API: reqres.in)
  static const String login = '/pub/authenticate';
  static const String register = '/pub/register';
  static const String getMe = '/pvt/customer';

  // Build path with optional query params for flexibility
  static String withQuery(String path, Map<String, dynamic>? query) {
    if (query == null || query.isEmpty) return path;
    final entries = query.entries.where((e) => e.value != null).map((e) => '${e.key}=${e.value}');
    return '$path?${entries.join('&')}';
  }
}
