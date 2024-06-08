import 'dart:developer';
import 'dart:io';
// import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppImageProvider extends ChangeNotifier {
  Uint8List? currentImage;
  List<String> savedImagePaths = [];
  double? _currentImageWidth;
  double? _currentImageHeight;
  Uint8List? get _currentImage => currentImage;
  double? get currentImageWidth => _currentImageWidth;
  double? get currentImageHeight => _currentImageHeight;

  changeImageFile(File image) {
    currentImage = image.readAsBytesSync();
    notifyListeners();
  }

  changeImaged(Uint8List imageBytes) async {
    currentImage = imageBytes;
    await calculateImageDimensions(imageBytes);
  }

  changeImage(Uint8List image) async {
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

  // void changeImage(Uint8List imageBytes) async {
  //   currentImage = imageBytes;
  //   await _calculateImageDimensions(imageBytes);
  //   notifyListeners();
  // }

  Future<void> calculateImageDimensions(Uint8List imageBytes) async {
    final img.Image image = img.decodeImage(imageBytes)!;
    _currentImageWidth = image.width.toDouble();
    _currentImageHeight = image.height.toDouble();
    log('Image Width: $_currentImageWidth, Image Height: $_currentImageHeight'); // Add this line
  }
}
