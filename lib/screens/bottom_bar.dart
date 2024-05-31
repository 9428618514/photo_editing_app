import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_editing_app/screens/discover_screen.dart';

import 'package:photo_editing_app/screens/profile_screen.dart';
import 'package:photo_editing_app/screens/choosing_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
  static int page = 0;
}

class _BottomBarState extends State<BottomBar> {
  final List pages = const [
    DiscoverScreen(),
    ChoosingScreen(),
    ProfileScreen()
  ];
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: pages[BottomBar.page],
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: BottomBar.page,
        height: 60,
        items: const <Widget>[
          Icon(
            CupertinoIcons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.add,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            CupertinoIcons.person,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: Colors.deepPurple.shade200,
        buttonBackgroundColor: Colors.deepPurple,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOutQuart,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            BottomBar.page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
