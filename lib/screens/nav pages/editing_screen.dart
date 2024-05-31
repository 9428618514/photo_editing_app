// // ignore_for_file: unused_local_variable

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:photo_editing_app/provider/app_image_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:screenshot/screenshot.dart';

// class EditingScreen extends StatefulWidget {
//   const EditingScreen({super.key});

//   @override
//   State<EditingScreen> createState() => _EditingScreenState();
// }

// class _EditingScreenState extends State<EditingScreen> {
//   late AppImageProvider appImageProvider;
//   @override
//   void initState() {
//     appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//     // controller.addWidget(
//     //   const Text("hello"),
//     // );
//     super.initState();
//   }

//   ScreenshotController screenShotController = ScreenshotController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.black,
//         title: const Text(
//           "Photo Editor",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         leading: CloseButton(
//           onPressed: () {
//             Navigator.of(context).pushReplacementNamed('/bottombar');
//           },
//           style: const ButtonStyle(
//               iconColor: WidgetStatePropertyAll(Colors.white)),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               final image = await screenShotController.capture();
//             },
//             child: const Text(
//               'Save',
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//       body: Center(
//         child: Screenshot(
//           controller: screenShotController,
//           child: Consumer<AppImageProvider>(
//               builder: (BuildContext context, value, Widget? child) {
//             if (value.currentImage != null) {
//               return Image.memory(value.currentImage!);
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         width: double.infinity,
//         height: 70,
//         color: Colors.white,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               _bottomBarItem(
//                 "images/edit_icons/crop-svgrepo-com.svg",
//                 'Crop',
//                 onPress: () {
//                   Navigator.of(context).pushNamed('/crop');
//                 },
//               ),
//               _bottomBarItem(
//                 "images/edit_icons/filters-svgrepo-com.svg",
//                 'Filters',
//                 onPress: () {
//                   Navigator.of(context).pushNamed('/filter');
//                 },
//               ),
//               _bottomBarItem(
//                 "images/edit_icons/effects-svgrepo-com.svg",
//                 'Effects',
//                 onPress: () {
//                   Navigator.of(context).pushNamed('/adjust');
//                 },
//               ),
//               _bottomBarItem(
//                   "images/edit_icons/text-size-svgrepo-com.svg", "Text",
//                   onPress: () {
//                 Navigator.of(context).pushNamed('/text');
//               }),
//               _bottomBarItem("images/edit_icons/frame-svgrepo-com.svg", "Frame",
//                   onPress: () {
//                 Navigator.of(context).pushNamed('/frame');
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _bottomBarItem(String image, String title, {required onPress}) {
//     return InkWell(
//       onTap: onPress,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 30, width: 30, child: SvgPicture.asset(image)),
//             const SizedBox(
//               height: 5,
//             ),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontSize: 12,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
// import 'package:permission_handler/permission_handler.dart';

import 'package:gallery_saver_updated/gallery_saver.dart';

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

  Future<void> _saveImage(Uint8List image) async {
    // Save to profile
    _updateUserProfile(image);

    // Save to gallery
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    final File imageFile = File('$path/edited_image.png');
    await imageFile.writeAsBytes(image);

    await [Permission.storage].request();
    if (await Permission.storage.isGranted) {
      await GallerySaver.saveImage(imageFile.path, albumName: "Edited Photos");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image saved to gallery and profile'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Permission to access storage denied'),
      ));
    }
  }

  void _updateUserProfile(Uint8List image) {
    // Implement your logic to update the user profile with the image
    // This might involve sending the image to a backend server or updating a local database
    print('Profile picture updated');
  }

  @override
  Widget build(BuildContext context) {
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
              }
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _bottomBarItem(
                "images/edit_icons/crop-svgrepo-com.svg",
                'Crop',
                onPress: () {
                  Navigator.of(context).pushNamed('/crop');
                },
              ),
              _bottomBarItem(
                "images/edit_icons/filters-svgrepo-com.svg",
                'Filters',
                onPress: () {
                  Navigator.of(context).pushNamed('/filter');
                },
              ),
              _bottomBarItem(
                "images/edit_icons/effects-svgrepo-com.svg",
                'Effects',
                onPress: () {
                  Navigator.of(context).pushNamed('/adjust');
                },
              ),
              _bottomBarItem(
                  "images/edit_icons/text-size-svgrepo-com.svg", "Text",
                  onPress: () {
                Navigator.of(context).pushNamed('/text');
              }),
              _bottomBarItem("images/edit_icons/frame-svgrepo-com.svg", "Frame",
                  onPress: () {
                Navigator.of(context).pushNamed('/frame');
              }),
              _bottomBarItem("images/edit_icons/tint-svgrepo-com.svg", "Tint",
                  onPress: () {
                Navigator.of(context).pushNamed('/tint');
              })
            ],
          ),
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
