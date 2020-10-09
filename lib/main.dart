import 'package:flutter/material.dart';
import 'screen/splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'util/constant.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Constants.sharedPreferences =  await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save Contact',
      theme: ThemeData(
        fontFamily: 'Alike',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

