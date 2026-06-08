import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'verify_account_screen.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/login_primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
            const SizedBox(height: 28),
            const Text(
              'FORGOT PASSWORD',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 23,
                fontWeight: FontWeight.w900,
                height: 1.05,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Please enter your email below to receive\nyour password reset code.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.35,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 86),
            const AuthTextField(
              label: 'Email',
              value: 'dhruvitkhatrani@gmail.com',
              trailingIcon: Icons.check_rounded,
            ),
            const SizedBox(height: 90),
            LoginPrimaryButton(
              label: 'RESET PASSWORD',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (context) => const VerifyAccountScreen(),
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
