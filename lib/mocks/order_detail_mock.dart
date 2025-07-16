import 'package:lafyuu/models/order/order_detail.dart';
import 'package:lafyuu/models/product/product.dart';

final mockOrderDetail = OrderDetail(
  orderId: 'LQNSU346JK',
  orderDate: DateTime(2017, 8, 1),
  status: 'Shipping',
  itemCount: 2,
  totalPrice: 766.86,
  products: [
    Product(
      id: '1',
      name: 'Nike Air Zoom Pegasus 36 Miami',
      description: 'Running Shoes',
      price: 299.43,
      discount: 0.0,
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4,
    ),
    Product(
      id: '2',
      name: 'Nike Air Zoom Pegasus 36 Miami',
      description: 'Running Shoes',
      price: 299.43,
      discount: 0.0,
      imageUrl: 'https://via.placeholder.com/150',
      rating: 4,
    ),
  ],
  shippingDate: DateTime(2015, 1, 16),
  shippingMethod: 'POS Regular',
  trackingNumber: '000192848573',
  address: '2727 Lakeshore Rd, Nampa, Tennessee 78410',
  shippingCost: 40.0,
  importCharges: 128.0,
);
