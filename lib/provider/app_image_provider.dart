import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class AppImageProvider extends ChangeNotifier {
  Uint8List? currentImage;
  List<Uint8List> savedImage = [];

  Uint8List? get image => currentImage;
  List<Uint8List> get savedImages => savedImage;

  // Uint8List? get current => currentImage;

  changeImageFile(File image) {
    currentImage = image.readAsBytesSync();
    notifyListeners();
  }

  changeImage(Uint8List image) {
    currentImage = image;
    notifyListeners();
  }

  setImage(Uint8List image) {
    image = image;
    notifyListeners();
  }

  savedImageforProfile(Uint8List image) {
    savedImage.add(image);
    notifyListeners();
  }
}
