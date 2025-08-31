// lib/router.dart
import 'package:flutter/material.dart';
import 'package:fluttercreate/screens/home/home_screen.dart';
import 'package:fluttercreate/screens/select/select_screen.dart';

class Routes {
  static const String home = '/';
  static const String select = '/select';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
      case '/home': // opcional: aceita alias '/home'
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case select:
        return MaterialPageRoute(builder: (_) => const SelectScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
