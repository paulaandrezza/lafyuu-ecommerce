import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/data/account_menu_items.dart';
import 'package:lafyuu/widgets/menu/menu_item.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: ListView.builder(
        itemCount: accountMenuItems.length,
        itemBuilder: (context, index) {
          return MenuItem(item: accountMenuItems[index]);
        },
      ),
    );
  }
}
