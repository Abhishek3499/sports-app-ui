import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../presentation/widgets/onboarding_title.dart';

class OnboardingPageData {
  const OnboardingPageData({
    required this.image,
    required this.titleLines,
    required this.topLeftGlow,
    required this.bottomRightGlow,
    this.subtitle,
    this.primaryButtonLabel,
  });

  final String image;
  final List<OnboardingTitleLine> titleLines;
  final Color topLeftGlow;
  final Color bottomRightGlow;
  final String? subtitle;
  final String? primaryButtonLabel;
}

abstract final class OnboardingPages {
  static const all = [
    OnboardingPageData(
      image: AppAssets.onboardingOne,
      topLeftGlow: AppColors.lime,
      bottomRightGlow: AppColors.lime,
      titleLines: [
        OnboardingTitleLine([
          OnboardingTitlePart('PRO '),
          OnboardingTitlePart('FITNESS', isHighlighted: true),
        ]),
      ],
      subtitle: 'We train your body to be\ngreat and fit.',
      primaryButtonLabel: 'LET\'S START',
    ),
    OnboardingPageData(
      image: AppAssets.onboardingCouples,
      topLeftGlow: Color(0xFFF1CA58),
      bottomRightGlow: Color(0xFFFF805E),
      titleLines: [
        OnboardingTitleLine([OnboardingTitlePart('PERFECT BODY')]),
        OnboardingTitleLine([
          OnboardingTitlePart('DOING '),
          OnboardingTitlePart('CROSSFIT', isHighlighted: true),
        ]),
        OnboardingTitleLine([OnboardingTitlePart('EXERCISES')]),
      ],
    ),
    OnboardingPageData(
      image: AppAssets.onboardingStrongMan,
      topLeftGlow: Color(0xFFF1CA58),
      bottomRightGlow: Color(0xFFF1CA58),
      titleLines: [
        OnboardingTitleLine([OnboardingTitlePart('SHOT STRONG')]),
        OnboardingTitleLine([
          OnboardingTitlePart('TIMELESS', isHighlighted: true),
        ]),
        OnboardingTitleLine([OnboardingTitlePart('MAN TRAINING')]),
      ],
    ),
    OnboardingPageData(
      image: AppAssets.onboardingStrongWoman,
      topLeftGlow: Color(0xFFFF805E),
      bottomRightGlow: Color(0xFFFF805E),
      titleLines: [
        OnboardingTitleLine([OnboardingTitlePart('HEALTHY MUSCULAR')]),
        OnboardingTitleLine([
          OnboardingTitlePart('SPORTSWOMAN', isHighlighted: true),
        ]),
        OnboardingTitleLine([OnboardingTitlePart('STANDING')]),
      ],
    ),
  ];
}
