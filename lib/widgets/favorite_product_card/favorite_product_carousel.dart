import 'package:flutter/material.dart';
import 'package:lafyuu/mocks/favorite_products_mock.dart';
import 'package:lafyuu/models/product/product_card.dart';
import 'package:lafyuu/widgets/product_card/product_card_compact.dart';

class FavoriteProductCarousel extends StatelessWidget {
  final List<ProductCard> products = favoriteProductsMock;

  void handleDelete(int id) {}

  FavoriteProductCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final product = products[index];
          return SizedBox(
            width: 190,
            child: ProductCardCompact(
              product: product,
              onDelete: () => handleDelete,
              isFavorite: false,
            ),
          );
        },
      ),
    );
  }
}
