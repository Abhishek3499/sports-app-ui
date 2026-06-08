import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class AuthStepHeader extends StatelessWidget {
  const AuthStepHeader({
    super.key,
    required this.stepLabel,
    required this.title,
    required this.onBackPressed,
    required this.onSkipPressed,
  });

  final String stepLabel;
  final String title;
  final VoidCallback onBackPressed;
  final VoidCallback onSkipPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onBackPressed,
              icon: const Icon(Icons.chevron_left_rounded, size: 31),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 40, height: 40),
              alignment: Alignment.centerLeft,
            ),
            const Spacer(),
            TextButton(
              onPressed: onSkipPressed,
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                padding: EdgeInsets.zero,
                minimumSize: const Size(44, 40),
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0,
                ),
              ),
              child: const Text('Skip'),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          stepLabel,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 23,
            fontWeight: FontWeight.w900,
            height: 1.05,
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
