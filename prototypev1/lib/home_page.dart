import 'package:flutter/material.dart';
import 'package:prototypev1/page_not_found_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';

import 'animations/buildpage_route.dart';
import 'imagetext_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showSlideToSeeOtherText = true;
  static const primaryColor = Color.fromARGB(255, 113, 57, 58);
  static const primaryColorDark = Color.fromARGB(255, 36, 51, 66);
  static const primaryColorLight = Color.fromARGB(255, 180, 84, 64);
  static const backgroundColor = Color.fromARGB(255, 242, 226, 206);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5), () {
      setState(() {
        _showSlideToSeeOtherText = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColorDark,
        title: const Text('Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 80,
              width: 1000,
              child: Center(
                child: Text('Browse trough our collection!'),
              ),
            ),
            if (_showSlideToSeeOtherText)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Slide to see other'),
              ),
            CarouselSlider.builder(
              itemCount: 2, // Update this to the desired amount of images
              itemBuilder: (context, carouselIndex, realcarouselIndex) {
                return GestureDetector(
                  onTap: () {
                    if (carouselIndex == 0) {
                      Navigator.push(
                        context,
                        BuildPageRoute.buildPageRoute(const ImageTextScreen()),
                      );
                    } else if (carouselIndex == 1) {
                      Navigator.push(
                        context,
                        BuildPageRoute.buildPageRoute(PageNotFound()),
                      );
                    }
                  },
                  child: Image.asset(
                      'assets/images/carousel_image_$carouselIndex.png',
                      fit: BoxFit.cover),
                );
              },
              options: CarouselOptions(
                aspectRatio: 16 / 9,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 15),
                viewportFraction: 0.8,
                enlargeCenterPage: true,
                enlargeFactor: 0.6,
                padEnds: true,
              ),
            ),
            const SizedBox(
              height: 170,
              width: 411,
              child: Center(
//https://api.flutter.dev/flutter/dart-collection/HashMap-class.html (create hash map based on carousel index)
                child: Text('Description corresponding to carousel_index'),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text('Follow us for updates and more!'),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _socialButton(
                      'assets/images/reddit.png', 'https://example.com/1'),
                  _socialButton('assets/images/instagram.png',
                      'https://www.instagram.com/arsfabulas/'),
                  _socialButton(
                      'assets/images/youtube.png', 'https://example.com/3'),
                  _socialButton(
                      'assets/images/tiktok.png', 'https://example.com/4'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String imagePath, String url) {
    return InkWell(
      onTap: () async {
        // ignore: deprecated_member_use
        if (await canLaunch(url)) {
          // ignore: deprecated_member_use
          await launch(url);
        } else {
          debugPrint('Could not launch $url');
        }
      },
      child: Image.asset(
        imagePath,
        width: 48,
        height: 48,
      ),
    );
  }
}
