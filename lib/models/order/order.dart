class Order {
  final String orderId;
  final DateTime orderDate;
  final String status;
  final int itemCount;
  final double totalPrice;

  Order({
    required this.orderId,
    required this.orderDate,
    required this.status,
    required this.itemCount,
    required this.totalPrice,
  });
}
