import 'package:flutter/material.dart';
import 'package:acra/ui/app.dart';
import 'dart:async';
import 'package:flutter/services.dart';

Future<void> main() async {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    launchapp();
  });
}

Future<void> launchapp() async {
  runApp(new App());
}

// void main() => runApp(App());
