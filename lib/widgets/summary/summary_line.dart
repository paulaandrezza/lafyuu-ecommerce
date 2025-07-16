import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/models/summary_line_data.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';

class SummaryLine extends StatelessWidget {
  final SummaryLineData data;

  const SummaryLine({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final lineContent = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              data.label,
              style:
                  data.isHighlighted ? AppTextStyles.body2 : AppTextStyles.body,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Text(
              data.value,
              style:
                  data.isHighlighted
                      ? AppTextStyles.body3.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                      : AppTextStyles.body6,
              softWrap: true,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );

    if (data.isHighlighted) {
      return Column(
        children: [
          const Divider(thickness: 1, height: 24, color: AppColors.lightgrey),
          lineContent,
        ],
      );
    } else {
      return lineContent;
    }
  }
}
