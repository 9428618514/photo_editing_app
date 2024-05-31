import 'package:flutter/material.dart';

import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:provider/provider.dart';

class FrameScreen extends StatefulWidget {
  const FrameScreen({super.key});

  @override
  State<FrameScreen> createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen> {
  late AppImageProvider appImageProvider;
  @override
  void initState() {
    appImageProvider = Provider.of<AppImageProvider>(context, listen: false);
    super.initState();
  }

  var imageheight = 0;
  var imagewidth = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          Consumer<AppImageProvider>(
              builder: (BuildContext context, value, Widget? child) {
            if (value.currentImage != null) {
              return Container(
                height: 1000,
                width: 1000,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(value.currentImage!),
                  ),
                ),
                child: Container(
                  height: 650,
                  width: 700,
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












































// import 'dart:ui' as ui;

// import 'package:flutter/material.dart';

// class TestPainter extends CustomPainter {
//   final ui.Image image;

//   TestPainter({required this.image});

//   @override
//   void paint(Canvas canvas, Size size) {
//     //draw the image
//     canvas.drawImage(image, const Offset(0, 0), Paint());

//     double rectWidth = image.width.toDouble();
//     double rectHeight = image.height.toDouble();
//     final imageCenter = Offset(image.width / 2, image.height / 2);

//     //first frame
//     var border1 = Rect.fromCenter(
//         center: imageCenter, width: rectWidth + 1, height: rectHeight + 1);

//     var painting = Paint();
//     painting.color = Colors.red;
//     painting.strokeWidth = 2;
//     painting.style = PaintingStyle.stroke;

//     canvas.drawRect(border1, painting);

//     //second frame
//     var border2 = Rect.fromCenter(
//         center: imageCenter, width: rectWidth + 3, height: rectHeight + 3);

//     var painting2 = Paint();
//     painting2.color = Colors.green;
//     painting2.strokeWidth = 2;
//     painting2.style = PaintingStyle.stroke;

//     canvas.drawRect(
//       border2,
//       painting2,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
