import 'package:flutter/material.dart';
import 'package:prototypev1/screens/imagetext_screen.dart';
import 'package:prototypev1/screens/landing_screen.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void showLayoutGuidelines() {
  debugPaintSizeEnabled = true;
}

class SplashScreen extends StatelessWidget {
  static const primaryColor = Color.fromARGB(255, 113, 57, 58);
  static const primaryColorDark = Color.fromARGB(255, 36, 51, 66);
  static const primaryColorLight = Color.fromARGB(255, 180, 84, 64);
  static const backgroundColor = Color.fromARGB(255, 242, 226, 206);

  const SplashScreen({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
