import 'package:flutter/material.dart';
import 'package:lafyuu/models/product/product_card.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/services/auth/auth_service.dart';
import 'package:lafyuu/services/auth_manager.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/widgets/favorite_button.dart';

class ProductCardCompact extends StatelessWidget {
  final AuthManager _authManager = AuthManager();
  final ProductCard product;
  final VoidCallback? onDelete;
  final VoidCallback? toggleFavorite;
  final bool isFavorite;
  final bool isClient;

  ProductCardCompact({
    super.key,
    required this.product,
    this.onDelete,
    this.toggleFavorite,
    this.isFavorite = true,
    this.isClient = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.productDetails.path,
          arguments: product.id,
        );
      },

      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightgrey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.imageUrl,
                height: 160,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: Text(
                product.name,
                style: AppTextStyles.body5,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isFavorite) const SizedBox(height: 4),
            if (isFavorite)
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color:
                        index < product.rating!
                            ? Colors.amber
                            : AppColors.lightgrey,
                    size: 14,
                  );
                }),
              ),
            const SizedBox(height: 16),
            Text(
              '\$${(product.price * (1 - product.discount)).toStringAsFixed(2)}',
              style: AppTextStyles.bodyLightBlue,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.body.copyWith(
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.grey,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(product.discount * 100).toInt()}% Off',
                      style: AppTextStyles.body.copyWith(color: Colors.red),
                    ),
                  ],
                ),

                if (isClient)
                  FavoriteButton(
                    productId: product.id,
                    isFavorite: product.isFavorite,
                    toggleFavorite: toggleFavorite,
                  )
                else if (!isClient)
                  InkWell(
                    onTap: onDelete,
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.grey,
                      ),
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
