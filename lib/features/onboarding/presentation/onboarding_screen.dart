import 'package:flutter/material.dart';

import '../../auth/presentation/login_screen.dart';
import '../../../shared/widgets/app_gradient_background.dart';
import '../domain/onboarding_page_data.dart';
import 'widgets/home_indicator.dart';
import 'widgets/onboarding_footer_navigation.dart';
import 'widgets/onboarding_page_view.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  OnboardingPageData get _currentPage => OnboardingPages.all[_currentIndex];
  bool get _showsFooterNavigation => _currentIndex > 0;
  bool get _isLastPage => _currentIndex == OnboardingPages.all.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _setPage(int index) {
    setState(() => _currentIndex = index);
  }

  Future<void> _goToNextPage() async {
    if (_isLastPage) {
      await _openLogin();
      return;
    }

    final nextIndex = (_currentIndex + 1).clamp(
      0,
      OnboardingPages.all.length - 1,
    );

    await _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 520),
      curve: Curves.easeOut,
    );
  }

  Future<void> _openLogin() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppGradientBackground(
        topLeftColor: _currentPage.topLeftGlow,
        bottomRightColor: _currentPage.bottomRightGlow,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: OnboardingPages.all.length,
                  onPageChanged: _setPage,
                  itemBuilder: (context, index) {
                    return OnboardingPageView(
                      data: OnboardingPages.all[index],
                      pageIndex: index,
                      onPrimaryPressed: _goToNextPage,
                    );
                  },
                ),
              ),
              if (_showsFooterNavigation) ...[
                OnboardingFooterNavigation(
                  currentIndex: _currentIndex - 1,
                  total: OnboardingPages.all.length - 1,
                  onSkip: _openLogin,
                  onNext: _goToNextPage,
                ),
                const SizedBox(height: 18),
              ],
              const HomeIndicator(),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
