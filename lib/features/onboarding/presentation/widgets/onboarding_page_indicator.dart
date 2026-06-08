import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class OnboardingPageIndicator extends StatelessWidget {
  const OnboardingPageIndicator({
    super.key,
    required this.currentIndex,
    required this.total,
  });

  final int currentIndex;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (index) {
        final isActive = index == currentIndex;

        return Container(
          width: isActive ? 13 : 7,
          height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: isActive ? AppColors.lime : Colors.black,
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
