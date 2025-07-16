import 'dart:convert';
import 'package:lafyuu/models/product/product.dart';
import 'package:lafyuu/services/api/api_client.dart';

class CartService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Product>> get() async {
    try {
      final response = await _apiClient.get('/cart/items/');

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        final List<dynamic> jsonList = jsonMap['cartItems'];

        return jsonList
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception('Failed to load products: ${errorResponse['error']}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future checkout() async {
    try {
      final response = await _apiClient.delete('/cart/items/cart');

      if (response.statusCode == 204) {
        return;
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception('Failed to make checkout: ${errorResponse['error']}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future addItemToCart(String productVariantId, int quantity) async {
    try {
      final response = await _apiClient.post(
        '/cart/items/',
        body: {"productVariantId": productVariantId, 'quantity': quantity},
      );

      if (response.statusCode == 201) {
        return;
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception(
          'Failed to add item to cart: ${errorResponse['error']}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future changeQuantity(String productVariantId, int quantity) async {
    try {
      final response = await _apiClient.put('/cart/items/$productVariantId', {
        'quantity': quantity,
      });

      if (response.statusCode == 204) {
        return;
      } else {
        final Map<String, dynamic> errorResponse = jsonDecode(response.body);
        throw Exception('Failed to change quantity: ${errorResponse['error']}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
