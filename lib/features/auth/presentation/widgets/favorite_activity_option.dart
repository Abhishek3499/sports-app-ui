import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class FavoriteActivityOption extends StatelessWidget {
  const FavoriteActivityOption({
    super.key,
    required this.label,
    required this.imagePath,
    this.onPressed,
  });

  final String label;
  final String imagePath;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        padding: EdgeInsets.zero,
        minimumSize: const Size(112, 136),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: SizedBox(
        // width: 112,
        // height: 136,
        child: Column(
          children: [
            Container(
              height: 102,
              alignment: Alignment.center,
              child: label == 'Meal plan'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        imagePath,
                        width: 102,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipOval(
                      child: Image.asset(
                        imagePath,
                        width: 102,
                        height: 102,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
