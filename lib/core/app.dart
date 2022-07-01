import 'package:flutter/material.dart';

import 'package:fluttanim/routes/routes.dart';

class FluttanimApp extends StatelessWidget {
  const FluttanimApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Nunito'),
      title: 'Fluttanim',
    );
  }
}
