import 'package:flutter/material.dart';
import 'package:lafyuu/mocks/order_detail_mock.dart';
import 'package:lafyuu/mocks/products_mock.dart';
import 'package:lafyuu/models/product/product.dart';
import 'package:lafyuu/presentation/build/summary/build_order_summary_lines.dart';
import 'package:lafyuu/presentation/build/summary/build_shipping_summary_lines.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/views/main/client/tabScreens/account/pages/order/order_status_step_indicator.dart';
import 'package:lafyuu/widgets/primary_button.dart';
import 'package:lafyuu/widgets/product_card/product_card_large_list.dart';
import 'package:lafyuu/widgets/summary/summary_card.dart';

class AccountOrderDetailPage extends StatelessWidget {
  final String orderId;
  List<Product> products = List.from(productsMock);

  AccountOrderDetailPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final order = mockOrderDetail;
    final shippingSummaryLines = buildShippingSummaryLines(order: order);
    final paymentSummaryLines = buildOrderSummaryLines(
      itemCount: order.products.length,
      totalPrice: order.totalPrice,
      shippingCost: 40.00,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Order Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderStatusStepIndicator(currentStatus: order.status),

            const SizedBox(height: 16),

            Text('Product', style: AppTextStyles.subtitle4),
            ProductCardLargeList(
              products: products,
              isOrderDetail: true,
              isScrollable: false,
            ),

            const SizedBox(height: 16),

            Text('Shipping Details:', style: AppTextStyles.subtitle4),
            SummaryCard(lines: shippingSummaryLines),

            const SizedBox(height: 16),

            Text('Payment Details:', style: AppTextStyles.subtitle4),
            SummaryCard(lines: paymentSummaryLines),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(label: 'Notify Me', onPressed: () {}),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
