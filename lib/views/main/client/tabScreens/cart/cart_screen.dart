import 'package:flutter/material.dart';
import 'package:lafyuu/models/product/product.dart';
import 'package:lafyuu/presentation/build/summary/build_order_summary_lines.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/services/cart/cart_service.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';
import 'package:lafyuu/utils/notification_helper.dart';
import 'package:lafyuu/widgets/product_card/product_card_large_list.dart';
import 'package:lafyuu/widgets/primary_button.dart';
import 'package:lafyuu/widgets/summary/summary_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cartService = CartService();
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCardProducts();
  }

  Future<void> _loadCardProducts() async {
    try {
      final response = await _cartService.get();
      setState(() {
        products = response;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error loading products: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _removeProduct(String id, String productVariantId) async {
    try {
      await _cartService.changeQuantity(productVariantId, 0);

      setState(() {
        products.removeWhere((product) => product.id == id);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting item: $e')));
    }
  }

  Future<void> _updateQuantity(
    String id,
    String productVariantId,
    int newQuantity,
  ) async {
    try {
      await _cartService.changeQuantity(productVariantId, newQuantity);

      setState(() {
        final index = products.indexWhere((product) => product.id == id);
        if (index != -1) {
          products[index] = products[index].copyWith(quantity: newQuantity);
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao alterar quantidade: $e')));
    }
  }

  Future<void> _checkout() async {
    try {
      await _cartService.checkout();

      Navigator.pushNamed(context, AppRoutes.cartSuccessScreen.path);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(title: Text('Your Cart', style: AppTextStyles.h2)),
      body:
          isLandscape
              ? Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ProductCardLargeList(
                        products: products,
                        onDelete: _removeProduct,
                        onQuantityChange: _updateQuantity,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: OrderSummary(
                        totalPrice: products.fold(
                          0.0,
                          (sum, p) => sum + p.price * (p.quantity ?? 1),
                        ),
                        itemCount: products.fold(
                          0,
                          (sum, p) => sum + (p.quantity ?? 1),
                        ),
                        isLandscape: isLandscape,
                      ),
                    ),
                  ),
                ],
              )
              : Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ProductCardLargeList(
                        products: products,
                        onDelete: _removeProduct,
                        onQuantityChange: _updateQuantity,
                      ),
                    ),
                  ),
                  OrderSummary(
                    totalPrice: products.fold(
                      0.0,
                      (sum, p) => sum + p.price * (p.quantity ?? 1),
                    ),
                    itemCount: products.fold(
                      0,
                      (sum, p) => sum + (p.quantity ?? 1),
                    ),
                    isLandscape: isLandscape,
                  ),
                ],
              ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryButton(label: 'Check Out', onPressed: _checkout),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final double totalPrice;
  final int itemCount;
  final bool isLandscape;

  const OrderSummary({
    super.key,
    required this.totalPrice,
    required this.itemCount,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    final summaryLines = buildOrderSummaryLines(
      itemCount: itemCount,
      totalPrice: totalPrice,
      shippingCost: itemCount > 0 ? 40.00 : 0.00,
    );

    final content = Padding(
      padding: EdgeInsets.all(isLandscape ? 8.0 : 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Coupon Code',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(8),
                      ),
                      borderSide: BorderSide(color: AppColors.lightgrey),
                    ),
                  ),
                ),
              ),

              SizedBox(
                width: 128,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(8),
                      ),
                    ),
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {},
                  child: Text('Apply', style: AppTextStyles.button),
                ),
              ),
            ],
          ),

          SummaryCard(lines: summaryLines),
        ],
      ),
    );

    if (isLandscape) {
      return SingleChildScrollView(child: content);
    } else {
      return content;
    }
  }
}
