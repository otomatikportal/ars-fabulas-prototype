import 'package:flutter/material.dart';
import 'package:prototypev1/screens/imagetext_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:prototypev1/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImageTextController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const primaryColor = Color.fromARGB(255, 113, 57, 58);
  static const primaryColorDark = Color.fromARGB(255, 36, 51, 66);
  static const primaryColorLight = Color.fromARGB(255, 180, 84, 64);
  static const backgroundColor = Color.fromARGB(255, 242, 226, 206);

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: primaryColor,
          primaryColorLight: primaryColorLight,
          primaryColorDark: primaryColorDark,
          // ignore: deprecated_member_use
          backgroundColor: backgroundColor,
          scaffoldBackgroundColor: backgroundColor),
      home: SplashScreen(),
    );
  }
}
