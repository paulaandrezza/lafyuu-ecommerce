import 'package:flutter/material.dart';
import 'package:lafyuu/services/product/product_service.dart';

class FavoriteButton extends StatefulWidget {
  final String productId;
  final bool isFavorite;
  final VoidCallback? toggleFavorite;

  const FavoriteButton({
    super.key,
    required this.productId,
    required this.isFavorite,
    this.toggleFavorite,
  });

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;
  final ProductService _productService = ProductService();

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  Future<void> _toggleFavorite() async {
    try {
      _productService.toggleFavoriteStatus(widget.productId, !isFavorite);
      widget.toggleFavorite?.call();
      setState(() {
        isFavorite = !isFavorite;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : Colors.grey,
      ),
      onPressed: _toggleFavorite,
    );
  }
}
