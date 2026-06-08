import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryGridItem({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular Image with Shadow
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.08),
                  blurRadius: 12,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
              image: DecorationImage(
                image: AssetImage(category.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Category Title
          Text(
            category.title,
            style: TextStyle(
              color: isDark ? Colors.white70 : AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
