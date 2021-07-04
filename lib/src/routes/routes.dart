import 'package:flutter/material.dart';
import 'package:tyba/src/pages/history/history_page.dart';
import 'package:tyba/src/pages/home/home_page.dart';
import 'package:tyba/src/pages/login/login_page.dart';
import 'package:tyba/src/pages/register/register_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    "/": (BuildContext context) => HomePage(),
    "login": (BuildContext context) => LoginPage(),
    "register": (BuildContext context) => RegisterPage(),
    "history": (BuildContext context) => HistoryPage(),
  };
}
