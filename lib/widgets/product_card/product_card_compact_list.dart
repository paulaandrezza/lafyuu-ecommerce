import 'package:flutter/material.dart';
import 'package:lafyuu/models/product/product_card.dart';
import 'product_card_compact.dart';

class ProductCardCompactList extends StatelessWidget {
  final List<ProductCard> products;
  final void Function(String)? onDelete;
  final void Function(String)? toggleFavorite;
  final bool isClient;

  const ProductCardCompactList({
    super.key,
    required this.products,
    this.onDelete,
    this.toggleFavorite,
    this.isClient = true,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 4 : 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: isLandscape ? 0.60 : 0.52,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCardCompact(
          product: product,
          onDelete: () => onDelete?.call(product.id),
          toggleFavorite: () => toggleFavorite?.call(product.id),
          isClient: isClient,
        );
      },
    );
  }
}
