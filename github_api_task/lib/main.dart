import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:github_api_task/src/core/di/injection_container.dart';
import 'package:github_api_task/src/core/resources/app_colors.dart';
import 'package:github_api_task/src/core/resources/style_manager.dart';
import 'package:github_api_task/src/core/utils/router.dart';
import 'package:github_api_task/src/data/data_source/local_data_source.dart';
import 'package:github_api_task/src/presentation/pages/bottom_nav_bar/bottom_nav_bar_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DatabaseHelper.instance.database;
  initialDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.white),
          scaffoldBackgroundColor: AppTheme.dark,
          appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: AppTheme.primaryColor),
            titleTextStyle: getSemiBoldStyle(color: AppTheme.primaryColor),
            backgroundColor: AppTheme.dark,
          ),
          useMaterial3: true,
        ),
        navigatorKey: RoutesHelper.navigatorKey,
        initialRoute: BottomNavBarView.routeName,
        onGenerateRoute: (settings) => RoutesHelper.generateRoute(settings),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
