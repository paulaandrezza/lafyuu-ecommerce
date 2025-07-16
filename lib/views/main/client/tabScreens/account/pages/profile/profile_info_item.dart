import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/models/profile_info_item.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';

class ProfileInfoItem extends StatelessWidget {
  final ProfileInfoItemData item;

  const ProfileInfoItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Icon(item.icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Expanded(child: Text(item.label, style: AppTextStyles.subtitle4)),
            Text(
              item.value,
              style: AppTextStyles.body.copyWith(color: Colors.grey),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
