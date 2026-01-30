import '../../core/constants/endpoints.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_result.dart';
import '../../core/network/response_parser.dart';
import '../models/login_response.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  AuthRepository() : super();

  /// POST login. Test data: eve.holt@reqres.in / cityslicka (reqres.in).
  Future<ApiResult<LoginResponse>> login(String email, String password) async {
    return runCatching(() async {
      final response = await ApiClient.post(Endpoints.login, data: {'email': email, 'password': password});
      return response.asObject(LoginResponse.fromJson);
    });
  }
}
