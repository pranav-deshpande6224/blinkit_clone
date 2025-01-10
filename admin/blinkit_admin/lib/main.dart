import 'package:blinkit_admin/core/constants/constant_strings.dart';
import 'package:blinkit_admin/core/navigation/routing.dart';
import 'package:blinkit_admin/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';

void main() async {
  setUrlStrategy(PathUrlStrategy());
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: Constantstrings.appTitle,
      theme: AppTheme.themeData,
    );
  }
}
