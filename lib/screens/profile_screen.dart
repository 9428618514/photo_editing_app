import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:photo_editing_app/provider/app_image_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Consumer<AppImageProvider>(
        builder: (context, appImageProvider, child) {
          final savedImages = appImageProvider.savedImages;

          if (savedImages.isEmpty) {
            return const Center(
              child: Text('No images saved'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: savedImages.length,
            itemBuilder: (context, index) {
              return Image.memory(savedImages[index]);
            },
          );
        },
      ),
    );
  }
}
