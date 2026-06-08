import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/smooth_route.dart';
import 'height_screen.dart';
import 'widgets/measurement_step_body.dart';

class GoalWeightScreen extends StatelessWidget {
  const GoalWeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MeasurementStepBody(
        stepLabel: 'Step 4 of 7',
        title: 'WHAT\'S YOUR GOAL WEIGHT?',
        units: const ['LBS', 'KG'],
        initialUnit: 'KG',
        initialValue: '60',
        onNextPressed: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).push(
            SmoothPageRoute(page: const HeightScreen()),
          );
        },
      ),
    );
  }
}
