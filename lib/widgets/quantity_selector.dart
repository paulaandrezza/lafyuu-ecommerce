import 'package:flutter/material.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int>? onQuantityChanged;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (quantity > 1) onQuantityChanged?.call(quantity - 1);
            },
            child: Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightgrey),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: const Icon(Icons.remove, size: 16),
            ),
          ),
        ),
        Container(
          height: 32,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: AppColors.lightgrey),
          child: Text('$quantity', style: AppTextStyles.body2),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => onQuantityChanged?.call(quantity + 1),
            child: Container(
              height: 32,
              width: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.lightgrey),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: const Icon(Icons.add, size: 16),
            ),
          ),
        ),
      ],
    );
  }
}
