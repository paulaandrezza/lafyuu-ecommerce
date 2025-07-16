import 'package:intl/intl.dart';
import 'package:lafyuu/models/order/order_detail.dart';
import 'package:lafyuu/presentation/models/summary_line_data.dart';

List<SummaryLineData> buildShippingSummaryLines({required OrderDetail order}) {
  return [
    SummaryLineData(
      label: 'Date Shipping',
      value: DateFormat('MMMM d, yyyy').format(order.shippingDate),
    ),
    SummaryLineData(label: 'Shipping', value: order.shippingMethod),
    SummaryLineData(label: 'No. Resi', value: order.trackingNumber),
    SummaryLineData(label: 'Address', value: order.address),
  ];
}
