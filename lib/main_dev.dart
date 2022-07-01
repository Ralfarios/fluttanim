import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fluttanim/core/app.dart';
import 'package:fluttanim/core/config.dart';

Future main() async {
  await dotenv.load(fileName: ".env");

  const configuredApp = AppConfig(
    appTitle: 'Fluttanime',
    env: Env.dev,
    child: FluttanimApp(),
  );

  runApp(configuredApp);
}
