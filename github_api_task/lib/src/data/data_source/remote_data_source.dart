import 'package:github_api_task/src/core/errors/error_handler.dart';
import 'package:github_api_task/src/core/network/app_service_client/github_api.dart';
import 'package:github_api_task/src/models/follower_model.dart';
import 'package:github_api_task/src/models/github_user_model.dart';

abstract class RemoteDataSource {
  Future<List<Follower>> getUserFollowers(String username, int page);
  Future<GithubUser> getUserInfo(String username);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  Future<T> _handleApiCall<T>(Future<T> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (error) {
      throw ErrorHandler.handleException(error);
    }
  }

  @override
  Future<List<Follower>> getUserFollowers(String username, int page) async {
    return _handleApiCall(
        () => _appServiceClient.getUserFollowers(username, page));
  }

  @override
  Future<GithubUser> getUserInfo(String username) {
    return _handleApiCall(() => _appServiceClient.getUserInfo(username));
  }
}
