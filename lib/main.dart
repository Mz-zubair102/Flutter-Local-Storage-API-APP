import 'package:flutter/material.dart';
import 'package:local_storage_app/config/object_box.dart';
import 'package:local_storage_app/AB_DATA/ab_screens/button_screen.dart';
import 'package:local_storage_app/AB_DATA/ab_screens/home_screen.dart';
import 'package:local_storage_app/screenss/main_button_screen.dart';

late final ObjectBox objectBox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectBox = await ObjectBox.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ButtonScreen1(),
      /// AB SCREEN
      // home: ButtonScreen(),
    );
  }
}

