import 'package:flutter/material.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';

class OrderStatusStepIndicator extends StatelessWidget {
  final String currentStatus;

  OrderStatusStepIndicator({super.key, required this.currentStatus});

  final List<String> steps = ['Packing', 'Shipping', 'Arriving', 'Success'];

  Color _getStepColor(int index, int currentIndex) {
    if (index <= currentIndex) {
      return AppColors.primary;
    } else {
      return AppColors.lightgrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = steps.indexWhere(
      (step) => step.toLowerCase() == currentStatus.toLowerCase(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Row(
            children: List.generate(steps.length * 2 - 1, (index) {
              if (index.isEven) {
                final stepIndex = index ~/ 2;
                final stepColor = _getStepColor(stepIndex, currentIndex);

                return SizedBox(
                  width: 32,
                  height: 32,
                  child: Container(
                    decoration: BoxDecoration(
                      color: stepColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                );
              } else {
                final connectorColor =
                    (index ~/ 2) < currentIndex
                        ? AppColors.primary
                        : AppColors.lightgrey;

                return Expanded(
                  child: Container(height: 2, color: connectorColor),
                );
              }
            }),
          ),
        ),

        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              steps.map((step) {
                return Flexible(
                  fit: FlexFit.loose,
                  child: Center(
                    child: Text(
                      step,
                      style: AppTextStyles.subtitle3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}
