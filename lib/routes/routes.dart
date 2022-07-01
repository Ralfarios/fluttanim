import 'package:fluttanim/views/anime_detail/anime_detail_view.dart';
import 'package:flutter/material.dart';

import 'package:fluttanim/routes/constant.dart';
import 'package:fluttanim/views/home/home_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final name = settings.name;
    switch (name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case AppRoutes.detail:
        if (args != null) {
          return MaterialPageRoute(builder: (_) => AnimeDetailView(data: args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Unknown Error 500'),
        ),
      ),
    );
  }
}
