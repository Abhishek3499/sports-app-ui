import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class FitnessLevelOption extends StatelessWidget {
  const FitnessLevelOption({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 62,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.textPrimary : Colors.white,
          foregroundColor: isSelected ? Colors.white : AppColors.textSecondary,
          side: BorderSide(
            color: isSelected ? AppColors.textPrimary : AppColors.inputBorder,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: TextStyle(
            fontSize: isSelected ? 15 : 14,
            fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
