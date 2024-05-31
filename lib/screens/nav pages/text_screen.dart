import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
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
      // borderColor: Colors.white,
      // iconColor: Colors.black,
      // showDone: true,
      // showClose: true,
      // showFlip: true,
      // showStack: true,
      // showLock: true,
      // showAllBorders: true,
      // shouldScale: true,
      // shouldRotate: true,
      // shouldMove: true,
      // minScale: 0.5,
      // maxScale: 4,
      );
  bool editor = false;

  late AppImageProvider appImageProvider;
  @override
  void initState() {
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    // controller.addWidget(
    //   const Text("hello"),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Text",
              style: GoogleFonts.lato(
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () async {
                    {
                      Uint8List? bytes = await controller.saveAsUint8List();
                      appImageProvider.changeImage(bytes!);
                      if (!mounted) return;
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(CupertinoIcons.checkmark_alt))
            ],
          ),
          body: Center(
            child: Consumer<AppImageProvider>(
                builder: (BuildContext context, value, Widget? child) {
              if (value.currentImage != null) {
                return LindiStickerWidget(
                  controller: controller,
                  child: Image.memory(value.currentImage!),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
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
              decoration: const BoxDecoration(color: Colors.black),
              child: Text(
                "Add Text",
                style: GoogleFonts.lato(color: Colors.white),
              ),
            ),
          ),
        ),
        if (editor)
          Scaffold(
            backgroundColor: Colors.black87,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextEditor(
                  fonts: const [
                    "BeautifulPeople",
                    "BeautyMountains",
                    "Billabong",
                    "Billabong",
                    "BlackberryJam",
                    "BunchBlossoms",
                    "CinderelaRegular",
                    "Countryside",
                    "GrandHotel",
                    "Halimun"
                  ],
                  textStyle: const TextStyle(color: Colors.white),
                  minFontSize: 10,
                  maxFontSize: 70,

                  // textAlingment: textAlign,
                  decoration: EditorDecoration(
                    doneButton: const Icon(Icons.close, color: Colors.white),
                    fontFamily: const Icon(Icons.title, color: Colors.white),
                    colorPalette:
                        const Icon(Icons.palette, color: Colors.white),
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
                        controller.addWidget(Text(
                          text,
                          textAlign: align,
                          style: style,
                        ));
                      }
                    });
                  },
                ),
              ),
            ),
          )
      ],
    );
  }
}
