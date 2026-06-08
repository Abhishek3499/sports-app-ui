import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class OnboardingTitle extends StatelessWidget {
  const OnboardingTitle({
    super.key,
    required this.lines,
    this.highlightColor = AppColors.lime,
    this.fontSize = 30,
  });

  final List<OnboardingTitleLine> lines;
  final Color highlightColor;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      color: Colors.black,
      fontSize: fontSize,
      fontWeight: FontWeight.w900,
      height: 1.28,
      letterSpacing: 0,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: lines.map((line) {
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: baseStyle,
            children: line.parts.map((part) {
              return TextSpan(
                text: part.text,
                style: part.isHighlighted
                    ? TextStyle(color: highlightColor)
                    : null,
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class OnboardingTitleLine {
  const OnboardingTitleLine(this.parts);

  final List<OnboardingTitlePart> parts;
}

class OnboardingTitlePart {
  const OnboardingTitlePart(this.text, {this.isHighlighted = false});

  final String text;
  final bool isHighlighted;
}
