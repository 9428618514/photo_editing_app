import 'package:flutter/material.dart';
import 'package:photo_editing_app/provider/app_image_provider.dart';
import 'package:photo_editing_app/screens/nav%20pages/adjust_screen.dart';
import 'package:photo_editing_app/screens/bottom_bar.dart';
import 'package:photo_editing_app/screens/nav%20pages/crop_screen.dart';
import 'package:photo_editing_app/screens/nav%20pages/filter_screen.dart';
import 'package:photo_editing_app/screens/nav%20pages/editing_screen.dart';
import 'package:photo_editing_app/screens/nav%20pages/frame_screen.dart';
import 'package:photo_editing_app/screens/outbording_screen.dart';
import 'package:photo_editing_app/screens/choosing_screen.dart';
import 'package:photo_editing_app/screens/nav%20pages/text_screen.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppImageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // scaffoldBackgroundColor: const Color(0xff111111),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.black,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder>{
        '/': (_) => const OutBoardingScreen(),
        '/splash': (_) => const ChoosingScreen(),
        '/bottombar': (_) => const BottomBar(),
        '/home': (_) => const EditingScreen(),
        '/crop': (_) => const CropScreen(),
        '/filter': (_) => const FilterScreen(),
        '/adjust': (_) => const AdjustScreen(),
        '/text': (_) => const TextScreen(),
        '/frame': (_) => const FrameScreen(),
      },
      initialRoute: '/',
    );
  }
}
