import 'package:flutter/material.dart';
import 'package:profile/src/ui/index.dart';
import 'package:profile/src/ui/profile_page.dart';

class RoutePage {
  RoutePage._();

  static final init = "/";
  static final splash = "/splashPage";
  static final main = "/mainPage";

  static final todo = "/todoPage";
  static final todoDone = "/todoDonePage";
  static final todoAdd = "/addPage";
}

class Routes {
  Routes._();

  static var route = {
    RoutePage.init: (BuildContext context) => SplashPage(),
    RoutePage.main: (BuildContext context) => MainPage(),
    RoutePage.todo: (BuildContext context) => ProfilePage(),
    RoutePage.todoAdd: (BuildContext context) => AddProfilePage(),
  };
}
