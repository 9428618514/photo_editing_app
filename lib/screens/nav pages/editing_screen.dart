import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:gallery_saver_updated/gallery_saver.dart';
import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:photo_editing_app/screens/profile_screen.dart';

class EditingScreen extends StatefulWidget {
  const EditingScreen({super.key});

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  late AppImageProvider appImageProvider;
  ScreenshotController screenShotController = ScreenshotController();

  @override
  void initState() {
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  // Future<void> _saveImage(Uint8List image) async {
  //   // Save Image for profile screen
  //   appImageProvider.setImage(image);
  //   appImageProvider.savedImageforProfile(
  //       image); // Ensure this method adds image to the list

  //   // Save image for gallery
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = directory.path;
  //   final File imageFile = File('$path/edited_image.png');
  //   await imageFile.writeAsBytes(image);

  //   final status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     bool? result = await GallerySaver.saveImage(imageFile.path,
  //         albumName: "Edited Photos");
  //     if (result == true) {
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text('Image saved to gallery and profile'),
  //         ));
  //       }
  //     } else {
  //       if (mounted) {
  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //           content: Text('Failed to save image to gallery'),
  //         ));
  //       }
  //     }
  //   } else {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         content: Text('Permission to access storage denied'),
  //       ));
  //     }
  //   }
  // }
  Future<void> _saveImage(Uint8List image) async {
    // Save Image for profile screen
    appImageProvider.setImage(image);
    await appImageProvider.savedImageforProfile(image);

    // Save image for gallery
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final File imageFile = File('$path/edited_image.png');
    await imageFile.writeAsBytes(image);

    final status = await Permission.storage.request();
    if (status.isGranted) {
      bool? result = await GallerySaver.saveImage(imageFile.path,
          albumName: "Edited Photos");
      if (result == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Image saved to gallery and profile'),
          ));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Failed to save image to gallery'),
          ));
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Permission to access storage denied'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(
          "Photo Editor",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/bottombar');
          },
          style: const ButtonStyle(
              iconColor: MaterialStatePropertyAll(Colors.white)),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final image = await screenShotController.capture();
              if (image != null) {
                await _saveImage(image);
                if (mounted) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                }
              }
              print("Hiren");
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: Center(
        child: Screenshot(
          controller: screenShotController,
          child: Consumer<AppImageProvider>(
              builder: (BuildContext context, value, Widget? child) {
            if (value.currentImage != null) {
              return Image.memory(value.currentImage!);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _bottomBarItem(
                    "images/edit_icons/crop-svgrepo-com.svg",
                    'Crop',
                    onPress: () {
                      Navigator.of(context).pushNamed('/crop');
                    },
                  ),
                  SizedBox(width: 25),
                  _bottomBarItem(
                    "images/edit_icons/filters-svgrepo-com.svg",
                    'Filters',
                    onPress: () {
                      Navigator.of(context).pushNamed('/filter');
                    },
                  ),
                  SizedBox(width: 25),
                  _bottomBarItem(
                    "images/edit_icons/effects-svgrepo-com.svg",
                    'Effects',
                    onPress: () {
                      Navigator.of(context).pushNamed('/adjust');
                    },
                  ),
                  SizedBox(width: 25),
                  _bottomBarItem(
                      "images/edit_icons/text-size-svgrepo-com.svg", 'Text',
                      onPress: () {
                    Navigator.of(context).pushNamed('/text');
                  }),
                  SizedBox(width: 25),
                  _bottomBarItem(
                      "images/edit_icons/sticker-add-svgrepo-com.svg",
                      "Sticker", onPress: () {
                    Navigator.of(context).pushNamed('/sticker');
                  }),
                  SizedBox(width: 25),
                  _bottomBarItem(
                      "images/edit_icons/frame-svgrepo-com.svg", "Frame",
                      onPress: () {
                    Navigator.of(context).pushNamed('/frame');
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _bottomBarItem(String image, String title,
      {required void Function()? onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30, width: 30, child: SvgPicture.asset(image)),
            const SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
