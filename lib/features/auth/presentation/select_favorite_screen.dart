import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/smooth_route.dart';
import 'select_age_screen.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/auth_step_header.dart';
import 'widgets/favorite_activity_option.dart';
import 'widgets/login_primary_button.dart';

class SelectFavoriteScreen extends StatelessWidget {
  const SelectFavoriteScreen({super.key});

  static const _activities = [
    _FavoriteActivity('Running', AppAssets.favoriteRunning),
    _FavoriteActivity('Walking', AppAssets.favoriteWalking),
    _FavoriteActivity('Meal plan', AppAssets.favoriteMeal),
    _FavoriteActivity('Cycling', AppAssets.favoriteCycling),
    _FavoriteActivity('Yoga', AppAssets.favoriteYoga),
    _FavoriteActivity('Health', AppAssets.favoriteHealth),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthStepHeader(
              stepLabel: 'Step 1 of 7',
              title: 'SELECT YOUR FAVORITE',
              onBackPressed: () => Navigator.of(context).maybePop(),
              onSkipPressed: () {},
            ),
            const SizedBox(height: 52),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: 18,
                crossAxisSpacing: 20,

                mainAxisExtent: 160,
              ),
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                final activity = _activities[index];
                return FavoriteActivityOption(
                  label: activity.label,
                  imagePath: activity.imagePath,
                  onPressed: () {},
                );
              },
            ),
            const SizedBox(height: 80),
            LoginPrimaryButton(
              label: 'NEXT STEPS',
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push(
                  SmoothPageRoute(page: const SelectAgeScreen()),
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

class _FavoriteActivity {
  const _FavoriteActivity(this.label, this.imagePath);

  final String label;
  final String imagePath;
}
