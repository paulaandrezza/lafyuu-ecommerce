import 'package:lafyuu/presentation/models/summary_line_data.dart';

List<SummaryLineData> buildOrderSummaryLines({
  required int itemCount,
  required double totalPrice,
  required double shippingCost,
}) {
  return [
    SummaryLineData(
      label: 'Items ($itemCount)',
      value: '\$${totalPrice.toStringAsFixed(2)}',
    ),
    SummaryLineData(
      label: 'Shipping',
      value: '\$${shippingCost.toStringAsFixed(2)}',
    ),
    SummaryLineData(
      label: 'Import Charges',
      value: '\$${(totalPrice * 0.2).toStringAsFixed(2)}',
    ),
    SummaryLineData(
      label: 'Total Price',
      value: '\$${(totalPrice * 1.2 + shippingCost).toStringAsFixed(2)}',
      isHighlighted: true,
    ),
  ];
}
