import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

//dotenv for environment variables
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Riverpod
import 'package:flutter_riverpod/flutter_riverpod.dart';

//órden de importaciones
//1.- Importaciones de Dart
//2.- Importaciones de Flutter
//3.- Importaciones de terceros
//4.- Dependencias

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
