import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton._({
    required this.label,
    required this.icon,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
    required this.onPressed,
  });

  factory SocialLoginButton.google({required VoidCallback onPressed}) {
    return SocialLoginButton._(
      label: 'Connect with Google',
      icon: const _GoogleGlyph(),
      backgroundColor: AppColors.inputFill,
      foregroundColor: AppColors.textSecondary,
      borderColor: AppColors.inputBorder,
      onPressed: onPressed,
    );
  }

  factory SocialLoginButton.facebook({required VoidCallback onPressed}) {
    return SocialLoginButton._(
      label: 'Connect With Facebook',
      icon: const Text(
        'f',
        style: TextStyle(
          color: Colors.white,
          fontSize: 21,
          fontWeight: FontWeight.w800,
          letterSpacing: 0,
        ),
      ),
      backgroundColor: AppColors.facebookBlue,
      foregroundColor: Colors.white,
      borderColor: AppColors.facebookBlue,
      onPressed: onPressed,
    );
  }

  final String label;
  final Widget icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(alignment: Alignment.centerLeft, child: icon),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class _GoogleGlyph extends StatelessWidget {
  const _GoogleGlyph();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(
        color: Color(0xFF4285F4),
        fontSize: 15,
        fontWeight: FontWeight.w900,
        letterSpacing: 0,
      ),
    );
  }
}
