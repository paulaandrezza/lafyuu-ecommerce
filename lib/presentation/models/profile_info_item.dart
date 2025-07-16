import 'package:flutter/material.dart';

class ProfileInfoItemData {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  ProfileInfoItemData({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });
}
