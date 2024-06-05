import 'dart:developer';
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

  double frameSize = 20.0;
  String selectedAspectRatio = '1:1';
  Color frameColor = Colors.white;

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
        leading: const CloseButton(
          style: ButtonStyle(iconColor: MaterialStatePropertyAll(Colors.white)),
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
              size: 35,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Consumer<AppImageProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  if (value.currentImage != null) {
                    return Screenshot(
                      controller: screenshotController,
                      child: Center(
                        child: Container(
                          color: frameColor,
                          child: Padding(
                            padding: EdgeInsets.all(frameSize),
                            child: AspectRatio(
                              aspectRatio: getAspectRatio(selectedAspectRatio),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: MemoryImage(value.currentImage!),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Slider(
                    value: frameSize,
                    min: 0.0,
                    max: 50.0,
                    // divisions: 10,
                    label: frameSize.round().toString(),
                    onChanged: (double value) {
                      log("slider:$value");
                      setState(() {
                        frameSize = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // _buildColorButton(Colors.transparent),
                      buildColorButton(Colors.green),
                      buildColorButton(Colors.red),
                      buildColorButton(Colors.blue),
                      buildColorButton(Colors.yellow),
                      buildColorButton(Colors.black),
                      buildColorButton(Colors.white),
                      buildColorButton(Colors.purpleAccent),
                      buildColorButton(Colors.blueGrey),
                      buildColorButton(Colors.cyan),
                      buildColorButton(Colors.indigo),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Text('1:1', style: TextStyle(fontSize: 16)),
            label: '1:1',
          ),
          BottomNavigationBarItem(
            icon: Text('3:4', style: TextStyle(fontSize: 16)),
            label: '3:4',
          ),
          BottomNavigationBarItem(
            icon: Text('4:3', style: TextStyle(fontSize: 16)),
            label: '4:3',
          ),
          BottomNavigationBarItem(
            icon: Text('16:9', style: TextStyle(fontSize: 16)),
            label: '16:9',
          ),
          BottomNavigationBarItem(
            icon: Text('9:16', style: TextStyle(fontSize: 16)),
            label: '9:16',
          ),
          BottomNavigationBarItem(
            icon: Text('2:3', style: TextStyle(fontSize: 16)),
            label: '2:3',
          ),
          BottomNavigationBarItem(
            icon: Text('3:2', style: TextStyle(fontSize: 16)),
            label: '3:2',
          ),
          BottomNavigationBarItem(
            icon: Text('Movie', style: TextStyle(fontSize: 16)),
            label: 'Movie',
          ),
        ],
        onTap: (index) {
          // log(index.toString());
          setState(() {
            switch (index) {
              case 0:
                selectedAspectRatio = '1:1';
                break;
              case 1:
                selectedAspectRatio = '3:4';
                break;
              case 2:
                selectedAspectRatio = '4:3';
                break;
              case 3:
                selectedAspectRatio = '16:9';
                break;
              case 4:
                selectedAspectRatio = '9:16';
                break;
              case 5:
                selectedAspectRatio = '2:3';
                break;
              case 6:
                selectedAspectRatio = '3:2';
                break;
              case 7:
                selectedAspectRatio = 'Movie';
                break;
            }
          });
        },
        showSelectedLabels: false,
      ),
    );
  }

  double getAspectRatio(String ratio) {
    switch (ratio) {
      case '3:4':
        return 3 / 4;
      case '4:3':
        return 4 / 3;
      case '16:9':
        return 16 / 9;
      case '9:16':
        return 9 / 16;
      case '2:3':
        return 2 / 3;
      case '3:2':
        return 3 / 2;
      case 'Movie':
        return 21 / 9;
      case '1:1':
      default:
        return 1 / 1;
    }
  }

  Widget buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          frameColor = color;
        });
      },
      child: Container(
        width: 30,
        height: 30,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
        ),
      ),
    );
  }
}
