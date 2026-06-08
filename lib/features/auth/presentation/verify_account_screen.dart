import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/login_primary_button.dart';
import 'widgets/verification_code_field.dart';

class VerifyAccountScreen extends StatelessWidget {
  const VerifyAccountScreen({super.key});

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
            const SizedBox(height: 36),
            const Text(
              'VERIFY ACCOUNT',
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
              'Verify your account by entering verification\ncode we sent to dhruvit@gmail.com',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 1.35,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 106),
            const VerificationCodeField(),
            const SizedBox(height: 14),
            Center(
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 30),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    letterSpacing: 0,
                  ),
                ),
                child: const Text('Resend'),
              ),
            ),
            const SizedBox(height: 74),
            LoginPrimaryButton(label: 'RESET PASSWORD', onPressed: () {}),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
