// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lindi_sticker_widget/lindi_controller.dart';
// import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
// import 'package:photo_editing_app/provider/app_image_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:text_editor/text_editor.dart';

// class TextScreen extends StatefulWidget {
//   const TextScreen({super.key});

//   @override
//   State<TextScreen> createState() => _TextScreenState();
// }

// class _TextScreenState extends State<TextScreen> {
//   LindiController controller = LindiController(
//       // borderColor: Colors.white,
//       // iconColor: Colors.black,
//       // showDone: true,
//       // showClose: true,
//       // showFlip: true,
//       // showStack: true,
//       // showLock: true,
//       // showAllBorders: true,
//       // shouldScale: true,
//       // shouldRotate: true,
//       // shouldMove: true,
//       // minScale: 0.5,
//       // maxScale: 4,
//       );
//   bool editor = false;

//   late AppImageProvider appImageProvider;
//   @override
//   void initState() {
//     appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
//     // controller.addWidget(
//     //   const Text("hello"),
//     // );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: Colors.black,
//           appBar: AppBar(
//             leading: const CloseButton(
//               style:
//                   ButtonStyle(iconColor: WidgetStatePropertyAll(Colors.white)),
//             ),
//             title: const Text(
//               "Add Text",
//               style: TextStyle(
//                 color: Colors.white,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 onPressed: () async {
//                   {
//                     Uint8List? bytes = await controller.saveAsUint8List();
//                     appImageProvider.changeImage(bytes!);
//                     if (!mounted) return;
//                     // ignore: use_build_context_synchronously
//                     Navigator.pop(context);
//                   }
//                 },
//                 icon: const Icon(
//                   Icons.done,
//                   color: Colors.white,
//                   size: 29,
//                 ),
//               )
//             ],
//           ),
//           body: Center(
//             child: Consumer<AppImageProvider>(
//                 builder: (BuildContext context, value, Widget? child) {
//               if (value.currentImage != null) {
//                 return LindiStickerWidget(
//                   controller: controller,
//                   child: Image.memory(value.currentImage!),
//                 );
//               }
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }),
//           ),
//           bottomNavigationBar: GestureDetector(
//             onTap: () {
//               setState(() {
//                 editor = true;
//               });
//             },
//             child: Container(
//               alignment: Alignment.center,
//               width: double.infinity,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.black,
//                 border: Border.all(width: 5, color: Colors.white),
//                 borderRadius: BorderRadius.circular(
//                   5,
//                 ),
//               ),
//               child: Text(
//                 "Add Text",
//                 style: GoogleFonts.lato(
//                   color: Colors.white,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (editor)
//           Scaffold(
//             backgroundColor: Colors.black87,
//             body: SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: TextEditor(
//                   fonts: const [
//                     "BeautifulPeople",
//                     "BeautyMountains",
//                     "Billabong",
//                     "BlackberryJam",
//                     "BunchBlossoms",
//                     "CinderelaRegular",
//                     "Countryside",
//                     "GrandHotel",
//                     "Halimun",
//                     "imagesemonJelly",
//                     "OpenSans",
//                     "Oswald",
//                     "Quicksand",
//                     "QuiteMagicalRegular",
//                     "Tomatoes",
//                     "TropicalAsianDemoRegular",
//                     "VeganStyle",
//                   ],
//                   textStyle: const TextStyle(color: Colors.white),
//                   minFontSize: 10,
//                   maxFontSize: 70,

//                   // textAlingment: textAlign,
//                   decoration: EditorDecoration(
//                     doneButton: Icon(
//                       Icons.done,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                     fontFamily: const Icon(
//                       Icons.title,
//                       color: Colors.white,
//                     ),
//                     colorPalette:
//                         const Icon(Icons.palette, color: Colors.white),
//                     alignment: AlignmentDecoration(
//                       left: const Text(
//                         'left',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       center: const Text(
//                         'center',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       right: const Text(
//                         'right',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   onEditCompleted: (style, align, text) {
//                     setState(() {
//                       editor = false;
//                       if (text.isNotEmpty) {
//                         controller.addWidget(Text(
//                           text,
//                           textAlign: align,
//                           style: style,
//                         ));
//                       }
//                     });
//                   },
//                 ),
//               ),
//             ),
//           )
//       ],
//     );
//   }
// }
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:provider/provider.dart';
import 'package:text_editor/text_editor.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  LindiController controller = LindiController(
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
  bool editor = false;

  late AppImageProvider appImageProvider;

  @override
  void initState() {
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: const CloseButton(
              style: ButtonStyle(
                  iconColor: MaterialStatePropertyAll(Colors.white)),
            ),
            title: const Text(
              "Add Text",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  Uint8List? bytes = await controller.saveAsUint8List();
                  appImageProvider.changeImage(bytes!);
                  if (!mounted) return;
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.done,
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
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Stack(
                        children: [
                          Image.memory(value.currentImage!),
                          Positioned.fill(
                            child: ClipRect(
                              child: Container(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight,
                                child: LindiStickerWidget(
                                  controller: controller,
                                  child: Container(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              setState(() {
                editor = true;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(width: 5, color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Add Text",
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        if (editor)
          Consumer<AppImageProvider>(
            builder: (BuildContext context, value, Widget? child) {
              if (value.currentImage != null) {
                return Scaffold(
                  backgroundColor: Colors.black87,
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
                        child: Container(
                          width: value.currentImageWidth,
                          height: value.currentImageHeight,
                          color: Colors.transparent,
                          child: TextEditor(
                            fonts: const [
                              "BeautifulPeople",
                              "BeautyMountains",
                              "Billabong",
                              "BlackberryJam",
                              "BunchBlossoms",
                              "CinderelaRegular",
                              "Countryside",
                              "GrandHotel",
                              "Halimun",
                              "imagesemonJelly",
                              "OpenSans",
                              "Oswald",
                              "Quicksand",
                              "QuiteMagicalRegular",
                              "Tomatoes",
                              "TropicalAsianDemoRegular",
                              "VeganStyle",
                            ],
                            textStyle: const TextStyle(color: Colors.white),
                            minFontSize: 10,
                            maxFontSize: 70,
                            decoration: EditorDecoration(
                              doneButton: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 30,
                              ),
                              fontFamily: const Icon(
                                Icons.title,
                                color: Colors.white,
                              ),
                              colorPalette: const Icon(
                                Icons.palette,
                                color: Colors.white,
                              ),
                              alignment: AlignmentDecoration(
                                left: const Text(
                                  'left',
                                  style: TextStyle(color: Colors.white),
                                ),
                                center: const Text(
                                  'center',
                                  style: TextStyle(color: Colors.white),
                                ),
                                right: const Text(
                                  'right',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            onEditCompleted: (style, align, text) {
                              setState(() {
                                editor = false;
                                if (text.isNotEmpty) {
                                  controller.addWidget(
                                    Container(
                                      width: value.currentImageWidth,
                                      child: Text(
                                        text,
                                        textAlign: align,
                                        style: style,
                                      ),
                                    ),
                                  );
                                }
                              });
                            },
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
          )
      ],
    );
  }
}
