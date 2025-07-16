import 'package:flutter/material.dart';
import 'package:lafyuu/models/product/product.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/widgets/favorite_button.dart';
import 'package:lafyuu/widgets/quantity_selector.dart';

class ProductCardLarge extends StatelessWidget {
  final Product product;
  final VoidCallback? onDelete;
  final void Function(int)? onQuantityChange;
  final bool isOrderDetail;

  const ProductCardLarge({
    super.key,
    required this.product,
    this.onDelete,
    this.onQuantityChange,
    this.isOrderDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.lightgrey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.productDetails.path,
                arguments: product.id,
              );
            },
            child: Image.network(
              product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.name,
                            style: AppTextStyles.body2,
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        FavoriteButton(
                          productId: product.id,
                          isFavorite: product.isFavorite,
                        ),
                        if (!isOrderDetail)
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: onDelete,
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.bodyLightBlue,
                    ),
                    if (!isOrderDetail)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: QuantitySelector(
                          quantity: product.quantity ?? 1,
                          onQuantityChanged: onQuantityChange ?? (_) {},
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
