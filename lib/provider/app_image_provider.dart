import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class AppImageProvider extends ChangeNotifier {
  Uint8List? currentImage;
  double _currentImageHeight = 0;
  double _currentImageWidth = 0;
  double get currentImageHeight => _currentImageHeight;
  double get currentImageWidth => _currentImageWidth;
  Uint8List? get current => currentImage;
  void setImage(Uint8List images, double height, double width) {
    _currentImageHeight = height;
    _currentImageWidth = width;
    currentImage = images;
    notifyListeners();
  }

  changeImageFile(File image) {
    currentImage = image.readAsBytesSync();
    notifyListeners();
  }

  changeImage(Uint8List image) {
    currentImage = image;
    notifyListeners();
  }
}
