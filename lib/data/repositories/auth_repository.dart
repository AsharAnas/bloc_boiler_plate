import '../../core/constants/endpoints.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_result.dart';
import '../../core/network/response_parser.dart';
import '../../core/network/token_storage.dart';
import '../models/login_response.dart';
import '../models/user.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  AuthRepository() : super();

  /// POST login. Saves access token and uses it for subsequent requests (e.g. getMe).
  Future<ApiResult<LoginResponse>> login(String email, String password) async {
    return runCatching(() async {
      final response = await ApiClient.post(Endpoints.login, data: {'username': email, 'password': password, "deviceId": "!232312"});
      final loginResponse = response.asObject(LoginResponse.fromJson);
      await TokenStorage.setToken(loginResponse.token);
      return loginResponse;
    });
  }

  /// GET current user (uses saved token in headers via [ApiInterceptor]).
  Future<ApiResult<User>> getMe() async {
    return runCatching(() async {
      final response = await ApiClient.get(Endpoints.getMe);
      return response.asObject(User.fromJson);
    });
  }

  /// POST Register. Saves access token and uses it for subsequent requests (e.g. getMe).

  Future<ApiResult<LoginResponse>> register(String name, String email, String password) async {
    return runCatching(() async {
      final response = await ApiClient.post(
        Endpoints.register,
        data: {'email': email, 'password': password, "deviceId": "!232312", "fcmToken": "312312${DateTime.now()}", "paymentToken": "dsadsadsadas", "name": name},
      );
      return response.asObject(LoginResponse.fromJson);
    });
  }
}
