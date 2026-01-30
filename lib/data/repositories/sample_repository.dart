import '../../core/constants/endpoints.dart';
import '../../core/network/api_client.dart';
import '../../core/network/api_result.dart';
import '../../core/network/response_parser.dart';
import '../models/post.dart';
import 'base_repository.dart';

class SampleRepository extends BaseRepository {
  SampleRepository() : super();

  Future<ApiResult<List<Post>>> getPosts() async {
    return runCatching(() async {
      final response = await ApiClient.get(Endpoints.posts);
      return response.asList(Post.fromJson);
    });
  }

  Future<ApiResult<Post>> getPostById(int id) async {
    return runCatching(() async {
      final response = await ApiClient.get(Endpoints.postById(id));
      return response.asObject(Post.fromJson);
    });
  }

  Future<ApiResult<Post>> createPost(Map<String, dynamic> body) async {
    return runCatching(() async {
      final response = await ApiClient.post(Endpoints.posts, data: body);
      return response.asObject(Post.fromJson);
    });
  }

  Future<ApiResult<Post>> updatePost(int id, Map<String, dynamic> body) async {
    return runCatching(() async {
      final response = await ApiClient.put(Endpoints.postById(id), data: body);
      return response.asObject(Post.fromJson);
    });
  }

  Future<ApiResult<void>> deletePost(int id) async {
    return runCatching(() async {
      await ApiClient.delete<void>(Endpoints.postById(id));
    });
  }
}
