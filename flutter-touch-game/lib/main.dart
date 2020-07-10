import 'package:flutter/material.dart';

import 'widgets/game/flame_game_center.dart';

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GameCenter();
  }
}

void main() async {
  runApp(new MyApp());
}
