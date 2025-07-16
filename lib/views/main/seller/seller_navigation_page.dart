import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/data/bottom_nav/seller_bottom_nav_items.dart';
import 'package:lafyuu/theme/app_colors.dart';

class SellerNavigationPage extends StatefulWidget {
  const SellerNavigationPage({super.key});

  @override
  State<SellerNavigationPage> createState() => _SellerNavigationPageState();
}

class _SellerNavigationPageState extends State<SellerNavigationPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sellerBottomNavItems[_currentIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:
            (index) => setState(() {
              _currentIndex = index;
            }),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        backgroundColor: Colors.white,
        items:
            sellerBottomNavItems.map((item) {
              return BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              );
            }).toList(),
      ),
    );
  }
}
