import 'package:flutter/material.dart';
import 'package:lafyuu/routes/app_routes.dart';

class MenuItemData {
  final IconData icon;
  final String title;
  final AppRoutes? route;
  final Future<void> Function(BuildContext context)? onTap;
  final bool isDestructive;

  MenuItemData({
    required this.icon,
    required this.title,
    this.route,
    this.onTap,
    this.isDestructive = false,
  });
}
