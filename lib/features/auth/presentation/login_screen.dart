import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../home/presentation/screens/home_screen.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';
import 'widgets/auth_footer_prompt.dart';
import 'widgets/auth_screen_body.dart';
import 'widgets/auth_text_field.dart';
import 'widgets/login_primary_button.dart';
import 'widgets/social_login_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const AuthScreenBody(child: _LoginContent()),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent();

  @override
  Widget build(BuildContext context) {
    return Column(
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
          'WELCOME TO PRO FITNESS!',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 23,
            fontWeight: FontWeight.w900,
            height: 1.05,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Hello there, sign in to\ncontinue!',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.3,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 34),
        const AuthTextField(
          label: 'Email address',
          value: 'webvolty@gmail.com',
          trailingIcon: Icons.check_rounded,
        ),
        const SizedBox(height: 14),
        const AuthTextField(
          label: 'Password',
          value: '******',
          trailingIcon: Icons.visibility_off_rounded,
        ),
        const SizedBox(height: 14),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const ForgotPasswordScreen(),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 32),
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                letterSpacing: 0,
              ),
            ),
            child: const Text('Forgot Password?'),
          ),
        ),
        const SizedBox(height: 24),
        LoginPrimaryButton(
          label: 'LOGIN',
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pushAndRemoveUntil(
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
              (route) => false,
            );
          },
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'Or Login with',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              letterSpacing: 0,
            ),
          ),
        ),
        const SizedBox(height: 17),
        SocialLoginButton.google(onPressed: () {}),
        const SizedBox(height: 8),
        SocialLoginButton.facebook(onPressed: () {}),
        const SizedBox(height: 45),
        AuthFooterPrompt(
          message: 'Don\'t have an account?',
          actionLabel: 'Register!',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => const RegisterScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
