import 'package:flutter/material.dart';

import 'onboarding_page_indicator.dart';

class OnboardingFooterNavigation extends StatelessWidget {
  const OnboardingFooterNavigation({
    super.key,
    required this.currentIndex,
    required this.total,
    required this.onSkip,
    required this.onNext,
  });

  final int currentIndex;
  final int total;
  final VoidCallback onSkip;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _FooterTextButton(label: 'SKIP', onPressed: onSkip),
          OnboardingPageIndicator(currentIndex: currentIndex, total: total),
          _FooterTextButton(label: 'NEXT', onPressed: onNext),
        ],
      ),
    );
  }
}

class _FooterTextButton extends StatelessWidget {
  const _FooterTextButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Colors.black,
        minimumSize: const Size(54, 44),
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0,
        ),
      ),
      child: Text(label),
    );
  }
}
