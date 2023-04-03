class ImageData {
  final String imagePath;
  final List<String> texts;

  ImageData({required this.imagePath, required this.texts});
}

final List<ImageData> imagesData = [
  ImageData(
    imagePath: 'assets/images/1.jpg',
    texts: ['text 1', 'text 2', 'text 3'],
  ),
  ImageData(
    imagePath: 'assets/images/2.jpg',
    texts: ['text 4', 'text 5', 'text 6'],
  ),
  // Add more images and texts as needed
];
