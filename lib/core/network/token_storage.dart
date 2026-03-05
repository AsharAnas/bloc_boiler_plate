import 'package:shared_preferences/shared_preferences.dart';

/// Holds access token in memory and persists to SharedPreferences.
/// Call [init] at app startup so token is restored for subsequent requests.
class TokenStorage {
  TokenStorage._();

  static const _key = 'access_token';
  static String? _token;
  static SharedPreferences? _prefs;

  /// Call once at app startup (e.g. in [main] or before first API call).
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    _token = _prefs!.getString(_key);
  }

  /// Returns the current token (in-memory). After [init], this reflects persisted value.
  static String? get token => _token;

  /// Saves token in memory and to disk. Call after successful login.
  static Future<void> setToken(String value) async {
    _token = value;
    await _prefs?.setString(_key, value);
  }

  /// Clears token (e.g. on logout).
  static Future<void> clearToken() async {
    _token = null;
    await _prefs?.remove(_key);
  }
}
