import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_app_instructor/screens/splashscreen.dart';
import 'package:flutter/material.dart';

import 'components/constants.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        primaryColor: mainaccent,
      ),
      home: splashscreen(),
    );
  }
}
