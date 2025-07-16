import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/models/summary_line_data.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/widgets/summary/summary_line.dart';

class SummaryCard extends StatelessWidget {
  final List<SummaryLineData> lines;

  const SummaryCard({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightgrey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [...lines.map((line) => SummaryLine(data: line)).toList()],
        ),
      ),
    );
  }
}
