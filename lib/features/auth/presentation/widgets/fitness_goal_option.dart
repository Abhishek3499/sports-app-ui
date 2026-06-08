import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class FitnessGoalOption extends StatelessWidget {
  const FitnessGoalOption({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isSelected ? Colors.white : AppColors.textSecondary;

    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.textPrimary : Colors.white,
          foregroundColor: foregroundColor,
          side: BorderSide(
            color: isSelected ? AppColors.textPrimary : AppColors.inputBorder,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: foregroundColor),
            const SizedBox(width: 12),
            Text(label),
          ],
        ),
      ),
    );
  }
}
