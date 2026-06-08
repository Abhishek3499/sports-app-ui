import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/smooth_route.dart';
import 'fitness_goal_screen.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/auth_step_header.dart';
import 'widgets/fitness_level_option.dart';
import 'widgets/login_primary_button.dart';

class FitnessLevelScreen extends StatefulWidget {
  const FitnessLevelScreen({super.key});

  @override
  State<FitnessLevelScreen> createState() => _FitnessLevelScreenState();
}

class _FitnessLevelScreenState extends State<FitnessLevelScreen> {
  static const _levels = ['BEGINNER', 'Intermediate', 'Advanced'];

  String _selectedLevel = _levels.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthStepHeader(
              stepLabel: 'Step 6 of 7',
              title: 'WHAT\'S YOUR FITNESS LEVEL?',
              onBackPressed: () => Navigator.of(context).maybePop(),
              onSkipPressed: () {},
            ),
            const SizedBox(height: 148),
            ..._levels.map(
              (level) => Padding(
                padding: const EdgeInsets.only(bottom: 22),
                child: FitnessLevelOption(
                  label: level,
                  isSelected: level == _selectedLevel,
                  onPressed: () => setState(() => _selectedLevel = level),
                ),
              ),
            ),
            const SizedBox(height: 138),
            LoginPrimaryButton(
              label: 'NEXT STEPS',
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push(
                  SmoothPageRoute(page: const FitnessGoalScreen()),
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
