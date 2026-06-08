import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/smooth_route.dart';
import 'get_started_screen.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/auth_step_header.dart';
import 'widgets/fitness_goal_option.dart';
import 'widgets/login_primary_button.dart';

class FitnessGoalScreen extends StatefulWidget {
  const FitnessGoalScreen({super.key});

  @override
  State<FitnessGoalScreen> createState() => _FitnessGoalScreenState();
}

class _FitnessGoalScreenState extends State<FitnessGoalScreen> {
  static const _goals = [
    _FitnessGoal('Weight loss', Icons.assignment_outlined),
    _FitnessGoal('Gain muscle', Icons.fitness_center_outlined),
    _FitnessGoal('Improve fitness', Icons.sports_gymnastics_outlined),
  ];

  String _selectedGoal = 'Improve fitness';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthStepHeader(
              stepLabel: 'Step 7 of 7',
              title: 'WHAT\'S YOUR GOAL',
              onBackPressed: () => Navigator.of(context).maybePop(),
              onSkipPressed: () {},
            ),
            const SizedBox(height: 80),
            ..._goals.asMap().entries.map((entry) {
              final index = entry.key;
              final goal = entry.value;

              return Padding(
                padding: EdgeInsets.only(top: index == 2 ? 42 : 0, bottom: 35),
                child: FitnessGoalOption(
                  label: goal.label,
                  icon: goal.icon,
                  isSelected: goal.label == _selectedGoal,
                  onPressed: () => setState(() => _selectedGoal = goal.label),
                ),
              );
            }),
            const SizedBox(height: 144),
            LoginPrimaryButton(
              label: 'FINISH STEPS',
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push(
                  SmoothPageRoute(page: const GetStartedScreen()),
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

class _FitnessGoal {
  const _FitnessGoal(this.label, this.icon);

  final String label;
  final IconData icon;
}
