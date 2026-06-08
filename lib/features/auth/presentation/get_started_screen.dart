import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/login_primary_button.dart';
import '../../home/presentation/screens/home_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AuthScreenBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.chevron_left_rounded, size: 31),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints.tightFor(width: 40, height: 40),
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 56),
            const Center(
              child: Text(
                'LET\'S GET STARTED',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  height: 1.05,
                  letterSpacing: 0,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'The standard chunk of Lorem Ipsum\nused since the 1500s is reproduced below\nfor those interested.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                  letterSpacing: 0,
                ),
              ),
            ),
            const SizedBox(height: 34),
            Center(
              child: Image.asset(
                AppAssets.startCouple,
                width: 252,
                height: 252,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                    letterSpacing: 0,
                  ),
                  children: [
                    TextSpan(text: 'Sculpt your '),
                    TextSpan(
                      text: 'ideal body',
                      style: TextStyle(color: AppColors.lime),
                    ),
                    TextSpan(
                      text: ', free your\ntrue self, transform your life.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 72),
            LoginPrimaryButton(
              label: 'GET STARTED!',
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder<void>(
                    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      final fadeTween = Tween<double>(begin: 0.0, end: 1.0).chain(
                        CurveTween(curve: Curves.easeInOutCubic),
                      );
                      return FadeTransition(
                        opacity: animation.drive(fadeTween),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 600),
                  ),
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
