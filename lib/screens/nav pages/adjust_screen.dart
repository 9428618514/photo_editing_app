import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:photo_editing_app/utils/media_query.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:simple_fx/simple_fx.dart';

// ignore: must_be_immutable
class AdjustScreen extends StatefulWidget {
  const AdjustScreen({
    super.key,
  });

  @override
  State<AdjustScreen> createState() => _AdjustScreenState();
}

class _AdjustScreenState extends State<AdjustScreen> {
  late AppImageProvider appImageProvider;
  ScreenshotController screenshotController = ScreenshotController();
  double _brightness = 0;
  double _hue = 0;
  double _saturation = 100;
  // ImageProvide? imageProvider;
  @override
  void initState() {
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
        ),
        title: const Text(
          "Adjust",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              {
                Uint8List? bytes = await screenshotController.capture();
                appImageProvider.changeImage(bytes!);
                if (!mounted) return;
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              CupertinoIcons.checkmark_alt,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: displayHeight(context) / 1.5,
              width: double.infinity,
              child: Center(
                child: Consumer<AppImageProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    if (value.currentImage != null) {
                      return Screenshot(
                        controller: screenshotController,
                        child: SimpleFX(
                          imageSource: Image.memory(value.currentImage!),
                          brightness: _brightness,
                          hueRotation: _hue,
                          saturation: _saturation,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "brigtness ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            min: -50,
                            max: 50,
                            value: _brightness,
                            onChanged: (value) {
                              setState(
                                () {
                                  _brightness = value;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        const Text(
                          "contrast  ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            min: -50,
                            max: 50,
                            value: _hue,
                            onChanged: (value) {
                              setState(
                                () {
                                  _hue = value;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: [
                        const Text(
                          "hue         ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                            min: -100,
                            max: 100,
                            value: _saturation,
                            onChanged: (value) {
                              setState(
                                () {
                                  _saturation = value;
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
