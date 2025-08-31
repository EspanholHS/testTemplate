// lib/screens/router.dart
import 'package:flutter/material.dart';
import 'package:fluttercreate/screens/home/home_screen.dart';
import 'package:fluttercreate/screens/select/select_screen.dart';

class Routes {
  static const String home = '/';         // ✳️ ALTERE AQUI se quiser usar '/home'
  static const String select = '/select'; // ✳️ ALTERE AQUI se renomear a rota

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
      case '/home': // alias opcional
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case select:
        return MaterialPageRoute(builder: (_) => const SelectScreen());
      // ⚠️ Sem casos de Splash/Intro aqui
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')), // ✳️ ALTERE AQUI
          ),
        );
    }
  }
}
