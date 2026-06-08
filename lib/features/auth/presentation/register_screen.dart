import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/smooth_route.dart';
import 'select_favorite_screen.dart';
import 'widgets/auth_footer_prompt.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/login_primary_button.dart';
import 'widgets/social_login_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
            const SizedBox(height: 24),
            const Text(
              'CREATE ACCOUNTS',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 23,
                fontWeight: FontWeight.w900,
                height: 1.05,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Please enter your credentials to\nproceed',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.25,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 31),
            const AuthTextField(
              label: 'Full Name',
              value: 'Dhruvit Khatrani',
              trailingIcon: Icons.check_rounded,
            ),
            const SizedBox(height: 11),
            const AuthTextField(label: 'Phone', value: '9876543210'),
            const SizedBox(height: 11),
            const AuthTextField(
              label: 'Email address',
              value: 'dhruvitkhatrani@gmail.com',
            ),
            const SizedBox(height: 11),
            const AuthTextField(
              label: 'Password',
              value: '******',
              trailingIcon: Icons.visibility_off_rounded,
            ),
            const SizedBox(height: 24),
            LoginPrimaryButton(
              label: 'CREATE ACCOUNT',
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.of(context).push(
                  SmoothPageRoute(page: const SelectFavoriteScreen()),
                );
              },
            ),
            const SizedBox(height: 18),
            const Center(
              child: Text(
                'Or Register with',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                ),
              ),
            ),
            const SizedBox(height: 14),
            SocialLoginButton.google(onPressed: () {}),
            const SizedBox(height: 8),
            SocialLoginButton.facebook(onPressed: () {}),
            const SizedBox(height: 38),
            AuthFooterPrompt(
              message: 'Already have an account?',
              actionLabel: 'Login!',
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
