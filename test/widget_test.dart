import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sports_app/app.dart';
import 'package:sports_app/features/auth/presentation/fitness_goal_screen.dart';
import 'package:sports_app/features/auth/presentation/current_weight_screen.dart';
import 'package:sports_app/features/auth/presentation/fitness_level_screen.dart';
import 'package:sports_app/features/auth/presentation/forgot_password_screen.dart';
import 'package:sports_app/features/auth/presentation/get_started_screen.dart';
import 'package:sports_app/features/auth/presentation/goal_weight_screen.dart';
import 'package:sports_app/features/auth/presentation/height_screen.dart';
import 'package:sports_app/features/auth/presentation/login_screen.dart';
import 'package:sports_app/features/auth/presentation/register_screen.dart';
import 'package:sports_app/features/auth/presentation/select_age_screen.dart';
import 'package:sports_app/features/auth/presentation/select_favorite_screen.dart';
import 'package:sports_app/features/auth/presentation/verify_account_screen.dart';
import 'package:sports_app/features/onboarding/presentation/onboarding_screen.dart';
import 'package:sports_app/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:sports_app/features/onboarding/presentation/widgets/onboarding_primary_button.dart';
import 'package:sports_app/features/onboarding/presentation/widgets/onboarding_title.dart';
import 'package:sports_app/features/splash/presentation/splash_screen.dart';
import 'package:sports_app/shared/widgets/app_gradient_background.dart';

void main() {
  testWidgets('opens splash first, then onboarding', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const SportsApp());

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(OnboardingScreen), findsNothing);

    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pump(const Duration(milliseconds: 450));
    await tester.pump(const Duration(milliseconds: 1220));

    expect(find.byType(OnboardingScreen), findsOneWidget);
    expect(find.byType(OnboardingTitle), findsOneWidget);
    expect(find.byType(OnboardingPrimaryButton), findsOneWidget);
    expect(find.text('LET\'S START'), findsOneWidget);
    expect(find.byType(OnboardingPageIndicator), findsNothing);
    expect(find.text('SKIP'), findsNothing);
    expect(find.text('NEXT'), findsNothing);
  });

  testWidgets('moves through the onboarding screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
    await tester.pump(const Duration(milliseconds: 1220));

    expect(find.byType(OnboardingTitle), findsOneWidget);
    expect(find.byType(OnboardingPageIndicator), findsNothing);

    await tester.drag(find.byType(PageView), const Offset(-800, 0));
    await tester.pump(const Duration(milliseconds: 520));
    await tester.pump(const Duration(milliseconds: 1220));

    expect(
      find.byKey(const ValueKey('onboardingHeroAnimation1')),
      findsOneWidget,
    );

    final indicator = tester.widget<OnboardingPageIndicator>(
      find.byType(OnboardingPageIndicator),
    );
    expect(indicator.currentIndex, 0);
    expect(indicator.total, 3);

    final background = tester.widget<AppGradientBackground>(
      find.byType(AppGradientBackground),
    );
    expect(background.topLeftColor, const Color(0xFFF1CA58));
    expect(background.bottomRightColor, const Color(0xFFFF805E));

    await tester.tap(find.widgetWithText(TextButton, 'NEXT'));
    await tester.pump(const Duration(milliseconds: 520));
    await tester.pump(const Duration(milliseconds: 1220));

    expect(
      find.byKey(const ValueKey('onboardingHeroAnimation2')),
      findsOneWidget,
    );

    final secondIndicator = tester.widget<OnboardingPageIndicator>(
      find.byType(OnboardingPageIndicator),
    );
    expect(secondIndicator.currentIndex, 1);

    await tester.tap(find.widgetWithText(TextButton, 'NEXT'));
    await tester.pump(const Duration(milliseconds: 520));
    await tester.pump(const Duration(milliseconds: 1220));

    expect(
      find.byKey(const ValueKey('onboardingHeroAnimation3')),
      findsOneWidget,
    );

    final finalIndicator = tester.widget<OnboardingPageIndicator>(
      find.byType(OnboardingPageIndicator),
    );
    expect(finalIndicator.currentIndex, 2);

    final finalBackground = tester.widget<AppGradientBackground>(
      find.byType(AppGradientBackground),
    );
    expect(finalBackground.topLeftColor, const Color(0xFFFF805E));
    expect(finalBackground.bottomRightColor, const Color(0xFFFF805E));

    await tester.tap(find.widgetWithText(TextButton, 'NEXT'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('WELCOME TO PRO FITNESS!'), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1220));
  });

  testWidgets('opens login screen when skip is tapped', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
    await tester.pump(const Duration(milliseconds: 1220));

    await tester.drag(find.byType(PageView), const Offset(-800, 0));
    await tester.pump(const Duration(milliseconds: 520));
    await tester.pump(const Duration(milliseconds: 1220));

    await tester.tap(find.widgetWithText(TextButton, 'SKIP'));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text('WELCOME TO PRO FITNESS!'), findsOneWidget);
    expect(find.text('webvolty@gmail.com'), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
    expect(find.text('Connect with Google'), findsOneWidget);
    expect(find.text('Connect With Facebook'), findsOneWidget);
  });

  testWidgets('opens register screen from login footer prompt', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    final registerPrompt = find.textContaining('Register!');
    await tester.ensureVisible(registerPrompt);
    await tester.pumpAndSettle();
    await tester.tap(registerPrompt);
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
    expect(find.text('CREATE ACCOUNTS'), findsOneWidget);
    expect(find.text('Dhruvit Khatrani'), findsOneWidget);
    expect(find.text('9876543210'), findsOneWidget);
    expect(find.text('CREATE ACCOUNT'), findsOneWidget);
    expect(find.text('Or Register with'), findsOneWidget);

    final loginPrompt = find.textContaining('Login!');
    await tester.ensureVisible(loginPrompt);
    await tester.pumpAndSettle();
    await tester.tap(loginPrompt);
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(RegisterScreen), findsNothing);
  });

  testWidgets('opens forgot password screen from login link', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    expect(find.byType(ForgotPasswordScreen), findsOneWidget);
    expect(find.text('FORGOT PASSWORD'), findsOneWidget);
    expect(
      find.text(
        'Please enter your email below to receive\nyour password reset code.',
      ),
      findsOneWidget,
    );
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('dhruvitkhatrani@gmail.com'), findsOneWidget);
    expect(find.text('RESET PASSWORD'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(ForgotPasswordScreen), findsNothing);
  });

  testWidgets('opens verify account screen from reset password', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ForgotPasswordScreen()));

    await tester.tap(find.text('RESET PASSWORD'));
    await tester.pumpAndSettle();

    expect(find.byType(VerifyAccountScreen), findsOneWidget);
    expect(find.text('VERIFY ACCOUNT'), findsOneWidget);
    expect(
      find.text(
        'Verify your account by entering verification\ncode we sent to dhruvit@gmail.com',
      ),
      findsOneWidget,
    );
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('Resend'), findsOneWidget);
    expect(find.text('RESET PASSWORD'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(ForgotPasswordScreen), findsOneWidget);
    expect(find.byType(VerifyAccountScreen), findsNothing);
  });

  testWidgets('opens select favorite screen from create account', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: RegisterScreen()));

    await tester.tap(find.text('CREATE ACCOUNT'));
    await tester.pumpAndSettle();

    expect(find.byType(SelectFavoriteScreen), findsOneWidget);
    expect(find.text('Step 1 of 7'), findsOneWidget);
    expect(find.text('SELECT YOUR FAVORITE'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('Running'), findsOneWidget);
    expect(find.text('Walking'), findsOneWidget);
    expect(find.text('Meal plan'), findsOneWidget);
    expect(find.text('Cycling'), findsOneWidget);
    expect(find.text('Yoga'), findsOneWidget);
    expect(find.text('Health'), findsOneWidget);
    expect(find.text('NEXT STEPS'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(RegisterScreen), findsOneWidget);
    expect(find.byType(SelectFavoriteScreen), findsNothing);
  });

  testWidgets('opens age screen from select favorite next step', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SelectFavoriteScreen()));

    final nextButton = find.text('NEXT STEPS');
    await tester.ensureVisible(nextButton);
    await tester.pumpAndSettle();
    await tester.tap(nextButton);
    await tester.pumpAndSettle();

    expect(find.byType(SelectAgeScreen), findsOneWidget);
    expect(find.text('Step 2 of 7'), findsOneWidget);
    expect(find.text('HOW OLD ARE YOU?'), findsOneWidget);
    expect(find.text('Skip'), findsOneWidget);
    expect(find.text('27'), findsOneWidget);
    expect(find.text('NEXT STEPS'), findsOneWidget);

    await tester.drag(find.byType(ListWheelScrollView), const Offset(0, -72));
    await tester.pumpAndSettle();

    expect(find.text('29'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.chevron_left_rounded));
    await tester.pumpAndSettle();

    expect(find.byType(SelectFavoriteScreen), findsOneWidget);
    expect(find.byType(SelectAgeScreen), findsNothing);
  });

  testWidgets('opens measurement steps after age screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: SelectAgeScreen()));

    final ageNextButton = find.text('NEXT STEPS');
    await tester.ensureVisible(ageNextButton);
    await tester.pumpAndSettle();
    await tester.tap(ageNextButton);
    await tester.pumpAndSettle();

    expect(find.byType(CurrentWeightScreen), findsOneWidget);
    expect(find.text('Step 3 of 7'), findsOneWidget);
    expect(find.text('HOW MUCH DO YOU WEIGHT?'), findsOneWidget);
    expect(find.text('87'), findsOneWidget);
    expect(find.text('kg'), findsOneWidget);

    final currentWeightNextButton = find.widgetWithText(
      FilledButton,
      'NEXT STEPS',
    );
    await tester.ensureVisible(currentWeightNextButton);
    await tester.pumpAndSettle();
    await tester.tap(currentWeightNextButton);
    await tester.pumpAndSettle();

    expect(find.byType(GoalWeightScreen), findsOneWidget);
    expect(find.text('Step 4 of 7'), findsOneWidget);
    expect(find.text('WHAT\'S YOUR GOAL WEIGHT?'), findsOneWidget);
    expect(find.text('60'), findsOneWidget);

    final goalWeightNextButton = find.widgetWithText(
      FilledButton,
      'NEXT STEPS',
    );
    await tester.ensureVisible(goalWeightNextButton);
    await tester.pumpAndSettle();
    await tester.tap(goalWeightNextButton);
    await tester.pumpAndSettle();

    expect(find.byType(HeightScreen), findsOneWidget);
    expect(find.text('Step 5 of 7'), findsOneWidget);
    expect(find.text('HOW MUCH DO YOU HEIGHT?'), findsOneWidget);
    expect(find.text('85'), findsOneWidget);
    expect(find.text('cm'), findsOneWidget);

    final heightNextButton = find.widgetWithText(FilledButton, 'NEXT STEPS');
    await tester.ensureVisible(heightNextButton);
    await tester.pumpAndSettle();
    await tester.tap(heightNextButton);
    await tester.pumpAndSettle();

    expect(find.byType(FitnessLevelScreen), findsOneWidget);
    expect(find.text('Step 6 of 7'), findsOneWidget);
    expect(find.text('WHAT\'S YOUR FITNESS LEVEL?'), findsOneWidget);
    expect(find.text('BEGINNER'), findsOneWidget);
    expect(find.text('Intermediate'), findsOneWidget);
    expect(find.text('Advanced'), findsOneWidget);
    expect(find.text('NEXT STEPS'), findsOneWidget);

    await tester.tap(find.text('Advanced'));
    await tester.pumpAndSettle();
    expect(find.text('Advanced'), findsOneWidget);

    final fitnessNextButton = find.widgetWithText(FilledButton, 'NEXT STEPS');
    await tester.ensureVisible(fitnessNextButton);
    await tester.pumpAndSettle();
    await tester.tap(fitnessNextButton);
    await tester.pumpAndSettle();

    expect(find.byType(FitnessGoalScreen), findsOneWidget);
    expect(find.text('Step 7 of 7'), findsOneWidget);
    expect(find.text('WHAT\'S YOUR GOAL'), findsOneWidget);
    expect(find.text('Weight loss'), findsOneWidget);
    expect(find.text('Gain muscle'), findsOneWidget);
    expect(find.text('Improve fitness'), findsOneWidget);
    expect(find.text('FINISH STEPS'), findsOneWidget);

    await tester.tap(find.text('Weight loss'));
    await tester.pumpAndSettle();
    expect(find.text('Weight loss'), findsOneWidget);

    final finishStepsButton = find.widgetWithText(FilledButton, 'FINISH STEPS');
    await tester.ensureVisible(finishStepsButton);
    await tester.pumpAndSettle();
    await tester.tap(finishStepsButton);
    await tester.pumpAndSettle();

    expect(find.byType(GetStartedScreen), findsOneWidget);
    expect(find.text('LET\'S GET STARTED'), findsOneWidget);
    expect(find.textContaining('The standard chunk'), findsOneWidget);
    expect(find.byType(RichText), findsWidgets);
    expect(find.text('GET STARTED!'), findsOneWidget);
  });

  testWidgets('animates the onboarding hero image into place', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));

    final fadeSlideFinder = find.byKey(
      const ValueKey('onboardingHeroAnimation0'),
    );
    expect(fadeSlideFinder, findsOneWidget);

    final initialOpacity = tester.widget<Opacity>(
      find.descendant(of: fadeSlideFinder, matching: find.byType(Opacity)),
    );
    final initialTransform = tester.widget<Transform>(
      find.descendant(of: fadeSlideFinder, matching: find.byType(Transform)),
    );

    expect(initialOpacity.opacity, 0);
    expect(initialTransform.transform.getTranslation().y, 60);

    await tester.pump(const Duration(milliseconds: 800));

    final finalOpacity = tester.widget<Opacity>(
      find.descendant(of: fadeSlideFinder, matching: find.byType(Opacity)),
    );
    final finalTransform = tester.widget<Transform>(
      find.descendant(of: fadeSlideFinder, matching: find.byType(Transform)),
    );

    expect(finalOpacity.opacity, 1);
    expect(finalTransform.transform.getTranslation().y, 0);
  });

  testWidgets('animates the onboarding content after the hero image', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));

    final contentAnimationFinder = find.byKey(
      const ValueKey('onboardingContentAnimation0'),
    );
    expect(contentAnimationFinder, findsOneWidget);

    final initialOpacity = tester.widget<Opacity>(
      find.descendant(
        of: contentAnimationFinder,
        matching: find.byType(Opacity),
      ),
    );
    final initialTransform = tester.widget<Transform>(
      find.descendant(
        of: contentAnimationFinder,
        matching: find.byType(Transform),
      ),
    );

    expect(initialOpacity.opacity, 0);
    expect(initialTransform.transform.getTranslation().x, 42);
    expect(initialTransform.transform.getTranslation().y, 38);

    await tester.pump(const Duration(milliseconds: 520));
    await tester.pump(const Duration(milliseconds: 700));

    final finalOpacity = tester.widget<Opacity>(
      find.descendant(
        of: contentAnimationFinder,
        matching: find.byType(Opacity),
      ),
    );
    final finalTransform = tester.widget<Transform>(
      find.descendant(
        of: contentAnimationFinder,
        matching: find.byType(Transform),
      ),
    );

    expect(finalOpacity.opacity, 1);
    expect(finalTransform.transform.getTranslation().x, 0);
    expect(finalTransform.transform.getTranslation().y, 0);
  });
}
