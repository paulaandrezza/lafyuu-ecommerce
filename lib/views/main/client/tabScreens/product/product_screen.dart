import 'package:flutter/material.dart';
import 'package:lafyuu/mocks/products_mock_search.dart';
import 'package:lafyuu/models/enums/UserRole.dart';
import 'package:lafyuu/models/product/product_card.dart';
import 'package:lafyuu/services/auth_manager.dart';
import 'package:lafyuu/services/product/product_service.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/views/main/client/tabScreens/product/favorite/favorite_screen.dart';
import 'package:lafyuu/widgets/product_card/product_card_compact_list.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductService _productService = ProductService();
  final AuthManager _authManager = AuthManager();
  List<ProductCard> products = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  bool isClient = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _loadUserRole();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
  }

  Future<void> _loadProducts() async {
    try {
      final response = await _productService.get();
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

  void _removeProduct(String id) {
    setState(() {
      products.removeWhere((product) => product.id == id);
    });
  }

  Future<void> _loadUserRole() async {
    final user = await _authManager.getCurrentUser();
    setState(() {
      isClient = user?.role == UserRole.client;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<String> filteredProducts =
        mockProducts
            .where((product) => product.toLowerCase().contains(_searchText))
            .toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Product',
            prefixIcon: Icon(Icons.search, color: AppColors.primary),
          ),
        ),
        actions: [
          if (isClient)
            IconButton(
              icon: Icon(
                Icons.favorite_outline_outlined,
                color: AppColors.grey,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => FavoriteScreen()),
                );
              },
            )
          else
            IconButton(
              icon: Icon(Icons.add, color: AppColors.grey),
              onPressed: () {
                // TODO: implementar ação de adicionar produto
              },
            ),
          SizedBox(width: 16),
        ],
      ),
      body:
          _searchText.isEmpty
              ? isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ProductCardCompactList(
                      products: products,
                      onDelete: _removeProduct,
                      isClient: isClient,
                    ),
                  )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      filteredProducts[index],
                      style: AppTextStyles.body,
                    ),
                  );
                },
              ),
    );
  }
}
