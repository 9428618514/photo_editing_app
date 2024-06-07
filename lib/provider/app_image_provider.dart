// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';

// class AppImageProvider extends ChangeNotifier {
//   Uint8List? currentImage;
//   List<Uint8List> savedImage = [];

//   Uint8List? get image => currentImage;
//   List<Uint8List> get savedImages => savedImage;
//   changeImageFile(File image) {
//     currentImage = image.readAsBytesSync();
//     notifyListeners();
//   }

//   changeImage(Uint8List image) {
//     currentImage = image;
//     notifyListeners();
//   }

//   setImage(Uint8List image) {
//     image = image;
//     notifyListeners();
//   }

//   savedImageforProfile(Uint8List image) {
//     savedImage.add(image);
//     notifyListeners();
//   }
// }
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppImageProvider extends ChangeNotifier {
  Uint8List? currentImage;
  List<String> savedImagePaths = [];
  changeImageFile(File image) {
    currentImage = image.readAsBytesSync();
    notifyListeners();
  }

  changeImage(Uint8List image) {
    currentImage = image;
    notifyListeners();
  }

  AppImageProvider() {
    loadSavedImages();
  }

  void setImage(Uint8List image) {
    currentImage = image;
    notifyListeners();
  }

  Future<void> savedImageforProfile(Uint8List image) async {
    final directory = await getApplicationDocumentsDirectory();
    final String path =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final File file = File(path);
    await file.writeAsBytes(image);

    savedImagePaths.add(path);
    notifyListeners();
    await saveImagePaths();
  }

  Future<void> saveImagePaths() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('saved_images', savedImagePaths);
  }

  Future<void> loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    savedImagePaths = prefs.getStringList('saved_images') ?? [];
    notifyListeners();
  }

  List<Uint8List> get savedImages {
    return savedImagePaths.map((path) {
      final File file = File(path);
      return file.readAsBytesSync();
    }).toList();
  }
}
