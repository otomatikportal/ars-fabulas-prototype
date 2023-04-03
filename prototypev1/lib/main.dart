// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'image_data.dart';
import 'package:provider/provider.dart';

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
            return const LandingPage();
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

PageRoute _buildPageRoute(Widget destinationPage) {
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
} //sayfalar arası geçiş animasyonu

const primaryColor = Color.fromARGB(255, 113, 57, 58);
const primaryColorDark = Color.fromARGB(255, 36, 51, 66);
const primaryColorLight = Color.fromARGB(255, 180, 84, 64);
const backgroundColor = Color.fromARGB(255, 242, 226, 206);

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          //pushReplacement blocks going back
          context,
          _buildPageRoute(const HomePage()),
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
} //başlangıç sayfası

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showSlideToSeeOtherText = true;

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
      body: Column(
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
                      _buildPageRoute(const ImageTextScreen()),
                    );
                  } else if (carouselIndex == 1) {
                    Navigator.push(
                      context,
                      _buildPageRoute(const PageNotFound()),
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

class ImageTextScreen extends StatelessWidget {
  const ImageTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ImageTextController>(
        builder: (context, controller, child) {
          final imageData = imagesData[controller.currentIndex];
          final currentText = imageData.texts[controller.textIndex];

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imageData.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    Text(currentText,
                        style: TextStyle(fontSize: 35, color: Colors.white)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: controller.previousImage,
                          icon: Icon(Icons.arrow_back,
                          color: Colors.white,),
                        ),
                        IconButton(
                          onPressed: controller.nextImage,
                          icon: const Icon(
                            Icons.arrow_forward,
                            
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: controller.restart,
                          child: Text('Restart',selectionColor: Colors.white,),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context, _buildPageRoute(HomePage()));
                          },
                          child: Text('Home'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ImageTextController extends ChangeNotifier {
  int currentIndex = 0;
  int textIndex = 0;

  void nextImage() {
    if (textIndex < imagesData[currentIndex].texts.length - 1) {
      textIndex++;
    } else {
      if (currentIndex < imagesData.length - 1) {
        currentIndex++;
        textIndex = 0;
      }
    }
    notifyListeners();
  }

  void previousImage() {
    if (textIndex > 0) {
      textIndex--;
    } else {
      if (currentIndex > 0) {
        currentIndex--;
        textIndex = imagesData[currentIndex].texts.length - 1;
      }
    }
    notifyListeners();
  }

  void restart() {
    currentIndex = 0;
    textIndex = 0;
    notifyListeners();
  }
}

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
