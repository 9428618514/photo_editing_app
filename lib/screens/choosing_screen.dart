// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import 'package:photo_editing_app/helper/image_picker.dart';
// import 'package:photo_editing_app/provider/app_image_provider.dart';
// import 'package:provider/provider.dart';

// class ChoosingScreen extends StatefulWidget {
//   const ChoosingScreen({super.key});

//   @override
//   State<ChoosingScreen> createState() => _ChoosingScreenState();
// }

// class _ChoosingScreenState extends State<ChoosingScreen> {
//   late AppImageProvider imageProvider;

//   @override
//   void initState() {
//     imageProvider = Provider.of<AppImageProvider>(context, listen: false);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: Image.asset(
//               "images/splash.jpg",
//               fit: BoxFit.fitHeight,
//             ),
//           ),
//           Column(
//             children: [
//               const Expanded(
//                 child: Center(
//                   child: Text(
//                     "Photo Editor",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       wordSpacing: 10,
//                       letterSpacing: 5,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         AppImagePicker(source: ImageSource.gallery).pick(
//                             onPick: (File? image) {
//                           if (image == null) {
//                             Navigator.of(context)
//                                 .pushReplacementNamed('/bottombar');
//                           } else {
//                             imageProvider.changeImageFile(image);
//                             Navigator.of(context).pushNamed('/home');
//                           }
//                         });
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: 50,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.white70,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Column(
//                           children: [
//                             Text(
//                               "Gallery",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.deepPurple,
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Icon(
//                               Icons.photo_outlined,
//                               color: Colors.deepPurple,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         AppImagePicker(source: ImageSource.camera).pick(
//                             onPick: (File? image) {
//                           if (image == null) {
//                             Navigator.of(context)
//                                 .pushReplacementNamed('/bottombar');
//                           } else {
//                             imageProvider.changeImageFile(image);
//                             Navigator.of(context).pushNamed('/home');
//                           }
//                         });
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         height: 50,
//                         width: 100,
//                         decoration: BoxDecoration(
//                           color: Colors.white70,
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         child: Column(
//                           children: [
//                             Text(
//                               textAlign: TextAlign.center,
//                               "Camera",
//                               style: TextStyle(color: Colors.deepPurple),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Icon(
//                               Icons.camera_alt_outlined,
//                               color: Colors.deepPurple,
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:provider/provider.dart';

class ChoosingScreen extends StatefulWidget {
  const ChoosingScreen({super.key});

  @override
  State<ChoosingScreen> createState() => _ChoosingScreenState();
}

class _ChoosingScreenState extends State<ChoosingScreen> {
  late AppImageProvider imageProvider;
  bool isImagePickerActive = false;

  @override
  void initState() {
    imageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  Future<void> _getImage(ImageSource source) async {
    setState(() {
      isImagePickerActive = true;
    });
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile == null) {
        Navigator.of(context).pushReplacementNamed('/bottombar');
      } else {
        final image = File(pickedFile.path);
        imageProvider.changeImageFile(image);
        Navigator.of(context).pushNamed('/home');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isImagePickerActive = false;
    });
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
              "images/splash (2).jpg",
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: isImagePickerActive
                          ? null
                          : () => _getImage(ImageSource.gallery),
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Gallery",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            SvgPicture.asset(
                              "images/svg/gallery-1.svg",
                            )
                            // Icon(
                            //   Icons.photo_outlined,
                            //   color: Colors.deepPurple,
                            // )
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: isImagePickerActive
                          ? null
                          : () => _getImage(ImageSource.camera),
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            SvgPicture.asset(
                              "images/svg/camera.svg",
                            ),
                            // Icon(
                            //   Icons.camera_alt_outlined,
                            //   color: Colors.deepPurple,
                            // )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
