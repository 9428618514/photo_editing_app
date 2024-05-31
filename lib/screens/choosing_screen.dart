import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:photo_editing_app/helper/image_picker.dart';
import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:provider/provider.dart';

class ChoosingScreen extends StatefulWidget {
  const ChoosingScreen({super.key});

  @override
  State<ChoosingScreen> createState() => _ChoosingScreenState();
}

class _ChoosingScreenState extends State<ChoosingScreen> {
  late AppImageProvider imageProvider;

  @override
  void initState() {
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "images/splash.jpg",
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            children: [
              const Expanded(
                child: Center(
                  child: Text(
                    "Photo Editor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      wordSpacing: 10,
                      letterSpacing: 5,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          AppImagePicker(source: ImageSource.gallery).pick(
                              onPick: (File? image) {
                            if (image == null) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/bottombar');
                            } else {
                              imageProvider.changeImageFile(image);
                              Navigator.of(context).pushNamed('/home');
                            }
                          });
                        },
                        child: const Text(
                          "Gallary",
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          AppImagePicker(source: ImageSource.camera).pick(
                              onPick: (File? image) {
                            imageProvider.changeImageFile(image!);
                            Navigator.of(context).pushNamed('/home');
                          });
                        },
                        child: const Text(
                          "Camera",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
