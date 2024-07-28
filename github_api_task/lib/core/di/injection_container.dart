 
 
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:github_api_task/core/networking/app_service_client/github_api.dart';
import 'package:github_api_task/core/networking/dio/dio_client.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {




  //dio
  sl.registerLazySingleton<DioFactory>(() => DioFactory(sl()));

  Dio dio = await sl<DioFactory>().getDio();
  //app service client
  sl.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
}