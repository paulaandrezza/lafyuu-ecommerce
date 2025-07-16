class SummaryLineData {
  final String label;
  final String value;
  final bool isHighlighted;

  SummaryLineData({
    required this.label,
    required this.value,
    this.isHighlighted = false,
  });
}
