import 'package:lafyuu/models/product/product.dart';

import 'order.dart';

class OrderDetail extends Order {
  final List<Product> products;
  final DateTime shippingDate;
  final String shippingMethod;
  final String trackingNumber;
  final String address;
  final double shippingCost;
  final double importCharges;

  OrderDetail({
    required super.orderId,
    required super.orderDate,
    required super.status,
    required super.itemCount,
    required super.totalPrice,
    required this.products,
    required this.shippingDate,
    required this.shippingMethod,
    required this.trackingNumber,
    required this.address,
    required this.shippingCost,
    required this.importCharges,
  });
}
