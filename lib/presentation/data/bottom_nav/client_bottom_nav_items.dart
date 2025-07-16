import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/models/bottom_nav_item_data.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/account_screen.dart';
import 'package:lafyuu/views/main/client/tabScreens/cart/cart_screen.dart';
import 'package:lafyuu/views/main/client/tabScreens/product/product_screen.dart';
import 'package:lafyuu/views/main/client/tabScreens/home/home_screen.dart';
import 'package:lafyuu/views/main/client/tabScreens/offer/offer_screen.dart';

final List<BottomNavItemData> clientBottomNavItems = [
  BottomNavItemData(
    icon: Icons.home_outlined,
    label: 'Home',
    screen: HomeScreen(),
  ),
  BottomNavItemData(
    icon: Icons.inventory_2_outlined,
    label: 'Products',
    screen: ProductScreen(),
  ),
  BottomNavItemData(
    icon: Icons.shopping_cart_outlined,
    label: 'Cart',
    screen: CartScreen(),
  ),
  BottomNavItemData(
    icon: Icons.local_offer_outlined,
    label: 'Offers',
    screen: OfferScreen(),
  ),
  BottomNavItemData(
    icon: Icons.person_outlined,
    label: 'Account',
    screen: AccountScreen(),
  ),
];
