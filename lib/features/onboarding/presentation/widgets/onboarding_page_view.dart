import 'package:flutter/material.dart';

import '../../../../shared/widgets/fade_slide_in.dart';
import '../../domain/onboarding_page_data.dart';
import 'onboarding_primary_button.dart';
import 'onboarding_title.dart';

class OnboardingPageView extends StatelessWidget {
  const OnboardingPageView({
    super.key,
    required this.data,
    required this.pageIndex,
    required this.onPrimaryPressed,
  });

  final OnboardingPageData data;
  final int pageIndex;
  final VoidCallback onPrimaryPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final hasPrimaryButton = data.primaryButtonLabel != null;
        final heroScale = hasPrimaryButton ? 0.44 : 0.48;
        final heroHeight = (constraints.maxHeight * heroScale).clamp(
          230.0,
          400.0,
        );
        final topSpacerFlex = hasPrimaryButton ? 1 : 2;

        return Column(
          children: [
            Spacer(flex: topSpacerFlex),
            SizedBox(
              height: heroHeight,
              width: double.infinity,
              child: FadeSlideIn(
                key: ValueKey('onboardingHeroAnimation$pageIndex'),
                child: Image.asset(
                  data.image,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomCenter,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            SizedBox(height: hasPrimaryButton ? 33 : 43),
            FadeSlideIn(
              key: ValueKey('onboardingContentAnimation$pageIndex'),
              delay: const Duration(milliseconds: 520),
              duration: const Duration(milliseconds: 700),
              beginOffset: const Offset(42, 38),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnboardingTitle(lines: data.titleLines),
                  if (data.subtitle != null) ...[
                    const SizedBox(height: 21),
                    Text(
                      data.subtitle!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.18,
                        letterSpacing: 0,
                      ),
                    ),
                  ],
                  if (data.primaryButtonLabel != null) ...[
                    const SizedBox(height: 37),
                    OnboardingPrimaryButton(
                      label: data.primaryButtonLabel!,
                      onPressed: onPrimaryPressed,
                    ),
                  ],
                ],
              ),
            ),
            const Spacer(),
          ],
        );
      },
    );
  }
}
