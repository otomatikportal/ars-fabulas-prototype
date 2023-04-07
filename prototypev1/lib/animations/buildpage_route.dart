import 'package:flutter/material.dart';

class BuildPageRoute {
  static PageRoute buildPageRoute(Widget destinationPage) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Update the tween to animate opacity from 0.0 to 1.0.
        final tween = Tween<double>(begin: 0.0, end: 1.0);

        // Drive the animation using the tween.
        final opacityAnimation = animation.drive(tween);

        // Use the FadeTransition widget with the animated opacity value.
        return FadeTransition(
          opacity: opacityAnimation,
          child: child,
        );
      },
      transitionDuration: const Duration(
          seconds: 1), // Set the transition duration to 1 or 2 seconds.
    );
  }
}
