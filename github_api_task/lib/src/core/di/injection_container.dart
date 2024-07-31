 
 
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_api_task/src/core/network/app_service_client/github_api.dart';
import 'package:github_api_task/src/core/network/dio/dio_factory.dart';
import 'package:github_api_task/src/data/data_source/remote_data_source.dart';
import 'package:github_api_task/src/data/repositories/github_user_repo_impl.dart';
import 'package:github_api_task/src/logic/user_details/cubit/user_details_cubit.dart';
import 'package:github_api_task/src/logic/user_followers/cubit/github_user_cubit.dart';
import 'package:github_api_task/src/logic/repositories/github_user_repo.dart';

GetIt sl = GetIt.instance;

Future<void> initialDependencies() async {

  //dio

  sl.registerLazySingleton<Dio>(()=>DioFactory().getDio());
  
  //app service client
  sl.registerLazySingleton<AppServiceClient>(() => AppServiceClient(sl()));
  
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl()));
  
  sl.registerLazySingleton<GithubUserRepository>(() => GithubUserRepositoryImpl(sl()));
  
  sl.registerFactory<GithubUserCubit>(() => GithubUserCubit(sl()));

  sl.registerFactory<UserDetailsCubit>(() => UserDetailsCubit(sl()));
}