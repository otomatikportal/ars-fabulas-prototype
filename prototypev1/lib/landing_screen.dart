import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'animations/buildpage_route.dart';
import 'home_page.dart';


class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          //pushReplacement blocks going back
          context,
          BuildPageRoute.buildPageRoute(const HomePage()),
        );
      },
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/1.webp'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}