import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lafyuu/models/order/order.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMMM d, yyyy').format(order.orderDate);
    final formattedPrice = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 2,
    ).format(order.totalPrice);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.accountOrderDetails.path,
          arguments: order.orderId,
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightgrey),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(order.orderId, style: AppTextStyles.subtitle4),
            const SizedBox(height: 4),
            Text(
              'Order at Lafyuu : $formattedDate',
              style: AppTextStyles.subtitle,
            ),
            const Divider(height: 16, thickness: 1, color: AppColors.lightgrey),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Status', style: AppTextStyles.subtitle),
                Text(order.status, style: AppTextStyles.subtitle5),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Items', style: AppTextStyles.subtitle),
                Text(
                  '${order.itemCount} Items purchased',
                  style: AppTextStyles.subtitle5,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Price', style: AppTextStyles.subtitle),
                Text(
                  formattedPrice,
                  style: AppTextStyles.subtitle4.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
