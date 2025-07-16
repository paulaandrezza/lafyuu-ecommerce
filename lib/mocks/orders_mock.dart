import 'package:lafyuu/models/order/order.dart';

final List<Order> mockOrders = [
  Order(
    orderId: 'LQNSU346JK',
    orderDate: DateTime(2017, 8, 1),
    status: 'Shipping',
    itemCount: 2,
    totalPrice: 299.43,
  ),
  Order(
    orderId: 'SDG1345KJD',
    orderDate: DateTime(2017, 8, 1),
    status: 'Shipping',
    itemCount: 1,
    totalPrice: 299.43,
  ),
];
