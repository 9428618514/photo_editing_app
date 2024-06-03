import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class FrameScreen extends StatefulWidget {
  const FrameScreen({super.key});

  @override
  State<FrameScreen> createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  late AppImageProvider appImageProvider;
  @override
  void initState() {
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  int imageheight = 600;
  int imagewidth = 600;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const CloseButton(
            style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
          ),
          title: const Text(
            "Frame",
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
          // leading: const Icon(Icons.abc),
        ),
        body: Center(
          child: Stack(
            children: [
              Consumer<AppImageProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                if (value.currentImage != null) {
                  return Container(
                    height: 600,
                    width: 600,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(value.currentImage!),
                      ),
                    ),
                    child: Container(
                      height: imageheight.toInt().toDouble(),
                      width: imagewidth.toDouble(),
                      child: Image.asset(
                        "images/vecteezy_spring-branches-with-leaves-on-border-with-copy-space-green_10916979.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
              // Container(
              //   height: imageheight,
              //   width: imagewidth,
              //   decoration: const BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage(
              //           "images/vecteezy_spring-branches-with-leaves-on-border-with-copy-space-green_10916979.png",
              //         ),
              //         fit: BoxFit.fill),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
