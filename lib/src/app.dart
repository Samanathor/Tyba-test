import 'package:flutter/material.dart';
import 'package:tyba/src/routes/routes.dart';
import 'package:tyba/src/settings/settings.dart';

class MyApp extends StatelessWidget {
  final prefs = UserSettings();
  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: prefs.token != null && prefs.token != '' ? '/' : 'login',
      routes: getApplicationRoutes(),
    );
  }
}
