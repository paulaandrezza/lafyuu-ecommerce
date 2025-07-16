import 'product/product.dart';

class FavoriteProduct extends Product {
  FavoriteProduct({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.discount,
    required super.imageUrl,
    required super.rating,
    super.isFavorite = true,
  });
}
