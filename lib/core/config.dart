import 'package:flutter/material.dart';

enum Env { dev, staging, prod }

class AppConfig extends InheritedWidget {
  final Env env;
  final String appTitle;

  const AppConfig(
      {Key? key,
      required Widget child,
      required this.env,
      required this.appTitle})
      : super(key: key, child: child);

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  // 6
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
