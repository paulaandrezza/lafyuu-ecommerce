class VariantColor {
  final String id;
  final String name;
  final String hexCode;

  VariantColor({required this.id, required this.name, required this.hexCode});

  factory VariantColor.fromJson(Map<String, dynamic> json) {
    return VariantColor(
      id: json['id'],
      name: json['name'],
      hexCode: json['hexCode'],
    );
  }
}

class Variant {
  final String id;
  final double price;
  final double discount;
  final String imageUrl;
  final VariantColor color;

  Variant({
    required this.id,
    required this.price,
    required this.discount,
    required this.imageUrl,
    required this.color,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      id: json['id'],
      price: ((json['price'] ?? 200) as num).toDouble(),
      discount: (((json['discount'] ?? 10) / 100) as num).toDouble(),
      imageUrl:
          json['imageUrl'] ??
          'https://m.media-amazon.com/images/I/51206EEfBIL._AC_SY500_.jpg',
      color: VariantColor.fromJson(json['color']),
    );
  }
}

class ProductDetail {
  final String id;
  final String name;
  final String? description;
  final int? rating;
  final bool isFavorite;
  final String? weight;
  final String? dimensions;
  final String? model;
  final String? brand;
  final List<Variant> variants;

  ProductDetail({
    required this.id,
    required this.name,
    this.description,
    this.rating,
    this.isFavorite = false,
    this.weight,
    this.dimensions,
    this.model,
    this.brand,
    required this.variants,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['productId'],
      name: json['name'],
      description: json['description'],
      rating: 3 as int?,
      isFavorite: json['favorite'] ?? false,
      weight: json['weigth'] ?? '',
      dimensions: json['dimensions'] ?? '',
      model: json['model'] ?? '',
      brand: json['brand'] ?? '',
      variants:
          (json['variants'] as List<dynamic>?)
              ?.map(
                (variant) => Variant.fromJson(variant as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }
}
