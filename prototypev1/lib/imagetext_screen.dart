import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'animations/buildpage_route.dart';
import 'home_page.dart';
import 'image_data.dart';
import 'package:provider/provider.dart';

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
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
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
                          child: Text(
                            'Restart',
                            selectionColor: Colors.white,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context,
                                BuildPageRoute.buildPageRoute(HomePage()));
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
