import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/smooth_route.dart';
import 'fitness_level_screen.dart';
import 'widgets/measurement_step_body.dart';

class HeightScreen extends StatelessWidget {
  const HeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MeasurementStepBody(
        stepLabel: 'Step 5 of 7',
        title: 'HOW MUCH DO YOU HEIGHT?',
        units: const ['FEET', 'CM'],
        initialUnit: 'CM',
        initialValue: '85',
        onNextPressed: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).push(
            SmoothPageRoute(page: const FitnessLevelScreen()),
          );
        },
      ),
    );
  }
}
