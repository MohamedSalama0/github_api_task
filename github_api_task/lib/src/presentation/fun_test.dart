import 'package:flutter/material.dart';
import 'package:github_api_task/src/core/resources/app_assets.dart';

class FunTest extends StatelessWidget {
  static const String routeName = '/fun_test';
  const FunTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.asset(AppAssets.adel),
      ),
    );
  }
}
