import 'package:flutter/material.dart';
import 'package:profile/src/utils/index.dart';

// abstract class _BaseStatefulState<T extends StatefulWidget> extends State<T> {

//   _BaseStatefulState() {
//     // Parent constructor
//   }

//   void baseMethod() {
//     // Parent method
//   }
// }

// class BasePage extends StatefulWidget {
//   BasePage({Key key}) : super(key: key);

//   @override
//   BasePageState createState() => BasePageState();
// }

abstract class BasePageState<T extends StatefulWidget> extends State<T> {
  // int counter = 0;

  // void incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     counter++;
  //   });
  // }

  Widget builds(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return KeyboardHider(
      child: builds(context),
    );
  }
}
