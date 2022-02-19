

import 'package:calculator_app/views/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared_preferences/shared_preferences_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
       
        ChangeNotifierProvider<SharedPreferencesHelper>(
            create: (context) => SharedPreferencesHelper()),
      ],

      child: HomePage(),

    
    );
  }
}
