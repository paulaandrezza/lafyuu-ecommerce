import 'package:flutter/material.dart';

class BottomNavItemData {
  final IconData icon;
  final String label;
  final Widget screen;

  BottomNavItemData({
    required this.icon,
    required this.label,
    required this.screen,
  });
}
