import 'package:fluttanim/core/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttanim/core/app.dart';

void main() {
  const configuredApp = AppConfig(
    appTitle: 'Fluttanime',
    env: Env.dev,
    child: MyApp(),
  );

  runApp(configuredApp);
}
