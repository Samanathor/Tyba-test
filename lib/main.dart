import 'package:flutter/material.dart';
import 'package:tyba/src/app.dart';
import 'package:tyba/src/settings/settings.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = UserSettings();
  await prefs.initPrefs();

  runApp(MyApp());
}
