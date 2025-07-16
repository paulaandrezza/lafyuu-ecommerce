import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/models/menu_item_data.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/services/auth_manager.dart';

final List<MenuItemData> accountMenuItems = [
  MenuItemData(
    icon: Icons.person,
    title: 'Profile',
    route: AppRoutes.accountProfile,
  ),
  MenuItemData(
    icon: Icons.shopping_bag,
    title: 'Orders',
    route: AppRoutes.accountOrders,
  ),
  MenuItemData(
    icon: Icons.location_on,
    title: 'Address',
    route: AppRoutes.accountAddress,
  ),
  MenuItemData(
    icon: Icons.credit_card,
    title: 'Payment',
    route: AppRoutes.accountPayment,
  ),
  MenuItemData(
    icon: Icons.location_on_rounded,
    title: 'Geolocation',
    route: AppRoutes.AccountGelocation,
  ),
  MenuItemData(
    icon: Icons.logout,
    title: 'Logout',
    isDestructive: true,
    onTap: (context) async {
      await AuthManager().logout();
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.signIn.path,
        (route) => false,
      );
    },
  ),
];
