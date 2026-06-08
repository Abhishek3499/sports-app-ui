import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../training/presentation/widgets/popular_training_card.dart';
import '../widgets/favorite_meal_card.dart';

class MyFavoritesScreen extends StatefulWidget {
  const MyFavoritesScreen({super.key});

  @override
  State<MyFavoritesScreen> createState() => _MyFavoritesScreenState();
}

class _MyFavoritesScreenState extends State<MyFavoritesScreen> {
  String _selectedTab = 'Meal';

  // Mock favorite meals
  static const List<_MealData> _favoriteMeals = [
    _MealData(
      title: 'Greek salad with lettuce, green onion',
      kcal: '150 kcal',
      duration: '15 min',
      imagePath: 'assets/select_your_fav/meal.png',
    ),
    _MealData(
      title: 'Salad of fresh vegetables with olive oil',
      kcal: '270 kcal',
      duration: '10 min',
      imagePath: 'assets/select_your_fav/meal.png',
    ),
    _MealData(
      title: 'Healthy Chicken Quinoa Salad',
      kcal: '340 kcal',
      duration: '25 min',
      imagePath: 'assets/select_your_fav/meal.png',
    ),
  ];

  // Mock favorite workouts
  static const List<_WorkoutData> _favoriteWorkouts = [
    _WorkoutData(
      title: 'Full Shot Woman Stretching Arm',
      difficulty: 'Beginner',
      duration: '30 min',
      imagePath: 'assets/training/stretching.png',
    ),
    _WorkoutData(
      title: 'Athlete Practicing Monochrome',
      difficulty: 'Beginner',
      duration: '20 min',
      imagePath: 'assets/training/tennis.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 32,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'MY FAVORITES',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Tab Switcher (Meal / Workout)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: ['Meal', 'Workout'].map((tab) {
                final isSelected = tab == _selectedTab;
                Color tabBg;
                Color tabFg;

                if (isSelected) {
                  tabBg = isDark ? Colors.white : Colors.black;
                  tabFg = isDark ? Colors.black : Colors.white;
                } else {
                  tabBg = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF3F4F6);
                  tabFg = isDark ? Colors.white70 : const Color(0xFF4B5563);
                }

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() {
                          _selectedTab = tab;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: tabBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          tab,
                          style: TextStyle(
                            color: tabFg,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Content Area
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _buildList(isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(bool isDark) {
    if (_selectedTab == 'Meal') {
      return ListView.separated(
        key: const ValueKey('MealList'),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        physics: const BouncingScrollPhysics(),
        itemCount: _favoriteMeals.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final meal = _favoriteMeals[index];
          return FavoriteMealCard(
            title: meal.title,
            kcal: meal.kcal,
            duration: meal.duration,
            imagePath: meal.imagePath,
            onTap: () {
              HapticFeedback.lightImpact();
            },
            onFavoriteTap: () {
              HapticFeedback.mediumImpact();
            },
          );
        },
      );
    } else {
      return ListView.separated(
        key: const ValueKey('WorkoutList'),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        physics: const BouncingScrollPhysics(),
        itemCount: _favoriteWorkouts.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          final workout = _favoriteWorkouts[index];
          return PopularTrainingCard(
            title: workout.title,
            difficulty: workout.difficulty,
            duration: workout.duration,
            imagePath: workout.imagePath,
            isFavorite: true,
            onTap: () {
              HapticFeedback.lightImpact();
            },
          );
        },
      );
    }
  }
}

class _MealData {
  final String title;
  final String kcal;
  final String duration;
  final String imagePath;

  const _MealData({
    required this.title,
    required this.kcal,
    required this.duration,
    required this.imagePath,
  });
}

class _WorkoutData {
  final String title;
  final String difficulty;
  final String duration;
  final String imagePath;

  const _WorkoutData({
    required this.title,
    required this.difficulty,
    required this.duration,
    required this.imagePath,
  });
}
