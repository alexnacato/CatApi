import 'package:flutter/material.dart';
import '../view/cats_view.dart';

class AppRoutes {
  static const home = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const CatsView());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
