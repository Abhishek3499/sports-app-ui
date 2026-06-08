import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/smooth_route.dart';
import 'goal_weight_screen.dart';
import 'widgets/measurement_step_body.dart';

class CurrentWeightScreen extends StatelessWidget {
  const CurrentWeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MeasurementStepBody(
        stepLabel: 'Step 3 of 7',
        title: 'HOW MUCH DO YOU WEIGHT?',
        units: const ['LBS', 'KG'],
        initialUnit: 'KG',
        initialValue: '87',
        onNextPressed: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).push(
            SmoothPageRoute(page: const GoalWeightScreen()),
          );
        },
      ),
    );
  }
}
