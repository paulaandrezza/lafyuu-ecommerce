import 'package:flutter/material.dart';
import 'package:lafyuu/mocks/orders_mock.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/order/order_card.dart';

class AccountOrderPage extends StatelessWidget {
  const AccountOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order')),
      body: ListView.builder(
        itemCount: mockOrders.length,
        itemBuilder: (context, index) {
          return OrderCard(order: mockOrders[index]);
        },
      ),
    );
  }
}
