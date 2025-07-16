import 'package:flutter/material.dart';
import 'package:lafyuu/models/category_data.dart';
import 'package:lafyuu/theme/app_colors.dart';
import 'package:lafyuu/theme/app_text_styles.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryData> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLandscape ? 6 : 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: isLandscape ? 1.1 : 0.75,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        return Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.lightgrey, width: 1),
                color: Colors.white,
              ),
              child: Icon(category.icon, color: AppColors.primary),
            ),

            const SizedBox(height: 8),
            Text(
              category.label,
              style: AppTextStyles.body,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}
