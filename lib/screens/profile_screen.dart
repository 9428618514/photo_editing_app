import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Profile",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          actions: const [
            Icon(
              Icons.save_alt_outlined,
              size: 30,
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return Image.network(
                      "https://images-na.ssl-images-amazon.com/images/G/01/PLF/Daily_Ritual/2020/SPRING-DRIVERS/DAILY-RITUAL-COTTON-PUFF-SLEEVE_DT_CC_379x304_1x._SY304_CB410865121_.jpg");
                },
              ),
            ),
          ],
        ));
  }
}
