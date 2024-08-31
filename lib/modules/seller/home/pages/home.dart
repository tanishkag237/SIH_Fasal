import 'package:flutter/material.dart';
import 'package:sihfasal/modules/seller/additems/pages/additems.dart';

import '../../retailinfo_home/pages/seller_main.dart';
import '../widgets/bottomnav.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final ValueNotifier<int> _currentPageIndex = ValueNotifier<int>(0);

  final _destinations = const [
    BottomNavigationIcon(
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      label: "Home",
    ),
    BottomNavigationIcon(
      icon: Icons.add_box_outlined,
      selectedIcon: Icons.add_box,
      label: "Add item",
    ),
    BottomNavigationIcon(
      icon: Icons.chat_outlined,
      selectedIcon: Icons.chat,
      label: "Chats",
    ),
  ];


  final screens = const [
    SellerMain(),
    Additems(), // Temporary placeholder
    PlaceholderWidget(title: "Chats"),
   
  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
        valueListenable: _currentPageIndex,
        builder: (context, index, _) {
          return screens[index];
        },
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
        child: ValueListenableBuilder<int>(
          valueListenable: _currentPageIndex,
          builder: (context, index, _) {
            return NavigationBar(
              destinations: _destinations,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              selectedIndex: index,
              indicatorColor: Colors.transparent,
              onDestinationSelected: (index) {
                _currentPageIndex.value = index;
              },
            );
          },
        ),
      ),



      

    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  const PlaceholderWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}