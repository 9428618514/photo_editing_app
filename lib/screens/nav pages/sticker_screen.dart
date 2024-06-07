import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:photo_editing_app/helper/stickers.dart';
import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

class StickerScreen extends StatefulWidget {
  const StickerScreen({super.key});

  @override
  State<StickerScreen> createState() => _StickerScreenState();
}

class _StickerScreenState extends State<StickerScreen> {
  late AppImageProvider appImageProvider;
  // ScreenshotController screenshotController = ScreenshotController();
  ScreenshotController screenshotController = ScreenshotController();
  bool editor = false;

  late LindiController controller = LindiController(
    // borderColor: Colors.white,
    iconColor: Colors.black,
    showDone: true,
    showClose: true,
    showFlip: true,
    showStack: true,
    showLock: true,
    showAllBorders: true,
    shouldScale: true,
    shouldRotate: true,
    shouldMove: true,
    minScale: 0.5,
    maxScale: 4,
  );
  String? selectedCategory;

  @override
  void initState() {
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Sticker",
          style: TextStyle(color: Colors.white),
        ),
        leading: const CloseButton(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                controller.clearAllBorders();
              });
              try {
                Uint8List? bytes = await screenshotController.capture();

                if (bytes != null) {
                  appImageProvider.changeImage(bytes);

                  if (!mounted) return;

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } else {
                  // Handle null bytes if needed
                  print('Screenshot capture failed');
                }
              } catch (e) {
                // Handle potential exceptions from capture
                print('Error capturing screenshot: $e');
              }
            },
            icon: const Icon(
              CupertinoIcons.checkmark_alt,
              color: Colors.white,
              size: 29,
            ),
          )
        ],
      ),
      body: Center(
        child: Consumer<AppImageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            if (value.currentImage != null) {
              return Screenshot(
                controller: screenshotController,
                child: LindiStickerWidget(
                  controller: controller,
                  child: Container(
                    height: 500,
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(value.currentImage!),
                      ),
                    ),
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        height: 100,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: Sticker.stickerCategories.keys.map((category) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory =
                            selectedCategory == category ? null : category;
                        // editor = true;
                      });
                    },
                    // child: Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: Image.asset(
                    //     category,
                    //     height: 40,
                    //   ),
                    // ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (selectedCategory != null)
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      Sticker.stickerCategories[selectedCategory]!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          controller.addWidget(
                            Image.asset(
                              Sticker
                                  .stickerCategories[selectedCategory]![index],
                              height: 50,
                            ),
                          );
                        });
                        editor = true;
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          Sticker.stickerCategories[selectedCategory]![index],
                          height: 400,
                          width: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
