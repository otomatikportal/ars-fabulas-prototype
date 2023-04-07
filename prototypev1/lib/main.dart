import 'package:flutter/material.dart';
import 'package:prototypev1/landing_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'imagetext_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImageTextController(),
      child: MyApp(),
    ),
  );
}

void showLayoutGuidelines() {
  debugPaintSizeEnabled = true;
}

class MyApp extends StatelessWidget {
  static const primaryColor = Color.fromARGB(255, 113, 57, 58);
  static const primaryColorDark = Color.fromARGB(255, 36, 51, 66);
  static const primaryColorLight = Color.fromARGB(255, 180, 84, 64);
  static const backgroundColor = Color.fromARGB(255, 242, 226, 206);

  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      home: FutureBuilder<void>(
        future: _loadImages(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LandingScreen();
          } else {
            return const SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _loadImages(BuildContext context) async {
    await precacheImage(const AssetImage('assets/images/1.webp'), context);
  }
}
