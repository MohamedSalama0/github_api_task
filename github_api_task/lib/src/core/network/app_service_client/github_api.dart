import 'package:dio/dio.dart';
import 'package:github_api_task/src/models/follower_model.dart';
import 'package:github_api_task/src/models/github_user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'github_api.g.dart';

@RestApi(baseUrl: "https://api.github.com")
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET("/users/{username}/followers")
  Future<List<Follower>> getUserFollowers(
    @Path("username") String username,
    @Query("page") int page,
  );

  @GET("/users/{username}")
  Future<GithubUser> getUserInfo(
    @Path("username") String username,
  );
}
