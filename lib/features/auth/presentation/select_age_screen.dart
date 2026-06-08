import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/smooth_route.dart';
import 'current_weight_screen.dart';
import 'widgets/age_wheel_picker.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/auth_step_header.dart';
import 'widgets/login_primary_button.dart';

class SelectAgeScreen extends StatelessWidget {
  const SelectAgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthStepHeader(
              stepLabel: 'Step 2 of 7',
              title: 'HOW OLD ARE YOU?',
              onBackPressed: () => Navigator.of(context).maybePop(),
              onSkipPressed: () {},
            ),
            const SizedBox(height: 80),
            const AgeWheelPicker(minAge: 5, maxAge: 90, initialAge: 27),
            const SizedBox(height: 140),
            LoginPrimaryButton(
              label: 'NEXT STEPS',
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push(
                  SmoothPageRoute(page: const CurrentWeightScreen()),
                );
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
