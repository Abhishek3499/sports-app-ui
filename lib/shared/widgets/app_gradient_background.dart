import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class AppGradientBackground extends StatelessWidget {
  const AppGradientBackground({
    super.key,
    required this.child,
    this.topLeftColor = AppColors.lime,
    this.bottomRightColor = AppColors.lime,
  });

  final Widget child;
  final Color topLeftColor;
  final Color bottomRightColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: AppColors.surface),
      child: Stack(
        children: [
          Positioned(
            top: -146,
            left: -151,
            child: _GradientGlow(
              size: 450,
              colors: [
                topLeftColor.withAlpha(204),
                topLeftColor.withAlpha(51),
                Colors.transparent,
              ],
              stops: [0, 0.6, 1],
            ),
          ),
          Positioned(
            bottom: -80,
            right: -90,
            child: _GradientGlow(
              size: 350,
              colors: [
                bottomRightColor.withAlpha(204),
                bottomRightColor.withAlpha(38),
                Colors.transparent,
              ],
              stops: [0, 0.5, 1],
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: const SizedBox.expand(),
            ),
          ),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

class _GradientGlow extends StatelessWidget {
  const _GradientGlow({
    required this.size,
    required this.colors,
    required this.stops,
  });

  final double size;
  final List<Color> colors;
  final List<double> stops;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: RadialGradient(colors: colors, stops: stops),
      ),
    );
  }
}
