import 'package:flutter/material.dart';
import 'package:lafyuu/mocks/favorite_products_mock.dart';
import 'package:lafyuu/models/product/product_card.dart';
import 'package:lafyuu/services/product/product_service.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/widgets/product_card/product_card_compact_list.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final ProductService _productService = ProductService();
  List<ProductCard> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final response = await _productService.get(isFavorite: true);
      setState(() {
        products = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _toggleFavorite(String id) {
    setState(() {
      products.removeWhere((product) => product.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products', style: AppTextStyles.h2),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ProductCardCompactList(
          products: products,
          onDelete: _toggleFavorite,
        ),
      ),
    );
  }
}
