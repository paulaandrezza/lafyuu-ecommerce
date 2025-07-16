import 'package:flutter/material.dart';
import 'package:lafyuu/presentation/models/menu_item_data.dart';
import 'package:lafyuu/routes/app_routes.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';

class MenuItem extends StatelessWidget {
  final MenuItemData item;

  const MenuItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.onTap != null) {
          item.onTap!(context);
        } else if (item.route != null) {
          Navigator.pushNamed(context, item.route!.path);
        }
      },

      splashColor: AppColors.lightgrey,
      highlightColor: AppColors.lightgrey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: item.isDestructive ? Colors.red : AppColors.primary,
            ),
            const SizedBox(width: 12),
            Text(
              item.title,
              style:
                  item.isDestructive
                      ? AppTextStyles.subtitle4.copyWith(color: Colors.red)
                      : AppTextStyles.subtitle4,
            ),
          ],
        ),
      ),
    );
  }
}
