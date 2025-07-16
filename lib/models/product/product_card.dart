class ProductCard {
  final String id;
  final String? productVariantId;
  final String name;
  final double price;
  final double discount;
  final String imageUrl;
  final int? rating;
  final int? quantity;
  final bool isFavorite;

  ProductCard({
    required this.id,
    this.productVariantId,
    required this.name,
    required this.price,
    required this.discount,
    required this.imageUrl,
    this.rating,
    this.quantity,
    this.isFavorite = false,
  });

  factory ProductCard.fromJson(Map<String, dynamic> json) {
    return ProductCard(
      id: json['id'],
      productVariantId: json['productVariantId'],
      name: json['name'],
      rating: 3 as int?,
      price: ((json['price'] ?? 200) as num).toDouble(),
      discount: (((json['discount'] ?? 10) / 100) as num).toDouble(),
      imageUrl:
          json['imageUrl'] ??
          'https://m.media-amazon.com/images/I/51206EEfBIL._AC_SY500_.jpg',
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
