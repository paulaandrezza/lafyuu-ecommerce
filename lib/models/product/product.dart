class Product {
  final String id;
  final String? productVariantId;
  final String name;
  final String? description;
  final double price;
  final double discount;
  final String imageUrl;
  final int? rating;
  final int? quantity;
  final bool isFavorite;
  final String? weight;
  final String? dimensions;
  final String? model;
  final String? brand;

  Product({
    required this.id,
    this.productVariantId,
    required this.name,
    this.description,
    required this.price,
    required this.discount,
    required this.imageUrl,
    this.rating,
    this.quantity,
    this.isFavorite = false,
    this.weight,
    this.dimensions,
    this.model,
    this.brand,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? json['productId'],
      productVariantId: json['productVariantId'],
      name: json['name'],
      description: json['description'],
      rating: 3 as int?,
      price: ((json['price'] ?? 200) as num).toDouble(),
      discount: (((json['discount'] ?? 10) / 100) as num).toDouble(),
      imageUrl:
          json['imageUrl'] ??
          'https://m.media-amazon.com/images/I/51206EEfBIL._AC_SY500_.jpg',
      quantity: json['quantity'] != null ? json['quantity'] as int : null,
      isFavorite: json['isFavorite'] ?? false,
      weight: json['weigth'] ?? '',
      dimensions: json['dimensions'] ?? '',
      model: json['model'] ?? '',
      brand: json['brand'] ?? '',
    );
  }

  Product copyWith({
    int? id,
    String? productVariantId,
    String? name,
    String? description,
    double? price,
    double? discount,
    String? imageUrl,

    int? quantity,
    bool? isFavorite,
  }) {
    return Product(
      id: this.id,
      productVariantId: this.productVariantId,
      name: this.name,
      description: this.description,
      price: this.price,
      discount: this.discount,
      imageUrl: this.imageUrl,
      quantity: quantity ?? this.quantity,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
