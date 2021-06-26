import 'package:flutter/material.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'constants/index.dart';
import 'routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        RouteObserverProvider.of(context),
      ],
      theme: MyTheme.myTheme,
      routes: Routes.route,
      initialRoute: RoutePage.init,
    );
  }
}
