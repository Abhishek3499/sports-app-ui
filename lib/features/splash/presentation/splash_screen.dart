import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../onboarding/presentation/onboarding_screen.dart';
import '../../../shared/widgets/app_gradient_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
    this.displayDuration = const Duration(milliseconds: 1600),
    this.transitionDuration = const Duration(milliseconds: 450),
  });

  final Duration displayDuration;
  final Duration transitionDuration;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _openOnboarding();
  }

  Future<void> _openOnboarding() async {
    await Future<void>.delayed(widget.displayDuration);

    if (!mounted) return;

    await Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        transitionDuration: widget.transitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) {
          return const OnboardingScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AppGradientBackground(
        child: SafeArea(child: Center(child: SplashLogo())),
      ),
    );
  }
}

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final logoWidth = (size.width * 0.58).clamp(170.0, 250.0);

    return Semantics(
      label: 'Sports app splash logo',
      image: true,
      child: Image.asset(
        AppAssets.splashLogo,
        width: logoWidth,
        fit: BoxFit.contain,
      ),
    );
  }
}
