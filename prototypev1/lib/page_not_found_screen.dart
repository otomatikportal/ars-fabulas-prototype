import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/images/404.jpg'),
      fit: BoxFit.cover,
    );
  }
}
