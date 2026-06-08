import 'package:flutter/material.dart';
import '../widgets/exercise_tile.dart';

class FullExerciseScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const FullExerciseScreen({super.key, this.onBackTap});

  @override
  State<FullExerciseScreen> createState() => _FullExerciseScreenState();
}

class _FullExerciseScreenState extends State<FullExerciseScreen> {
  String _selectedCategory = 'Cardio';

  final List<String> _categories = ['Cardio', 'Legs', 'Back', 'Chest'];

  // Static exercise data per category
  static const Map<String, List<_ExerciseData>> _exercises = {
    'Cardio': [
      _ExerciseData(
        title: 'Exercises with Jumping Rope',
        kcal: '110 kcal',
        duration: '10 min',
        difficulty: 'Beginner',
        imagePath: 'assets/training/jumprope.png',
      ),
      _ExerciseData(
        title: 'Exercises with Holding Jumping Rope',
        kcal: '135 kcal',
        duration: '8 min',
        difficulty: 'Beginner',
        imagePath: 'assets/training/jumprope.png',
      ),
      _ExerciseData(
        title: 'Exercises with Sitting Dumbbells',
        kcal: '135 kcal',
        duration: '5 min.',
        difficulty: 'Beginner',
        imagePath: 'assets/training/weights.png',
      ),
      _ExerciseData(
        title: 'Exercises with Sitting Dumbbells',
        kcal: '135 kcal',
        duration: '5 min.',
        difficulty: 'Beginner',
        imagePath: 'assets/training/weights.png',
      ),
      _ExerciseData(
        title: 'Exercises with Sitting Dumbbells',
        kcal: '135 kcal',
        duration: '5 min.',
        difficulty: 'Beginner',
        imagePath: 'assets/training/stretching.png',
      ),
    ],
    'Legs': [
      _ExerciseData(
        title: 'Weighted Squats',
        kcal: '150 kcal',
        duration: '15 min',
        difficulty: 'Medium',
        imagePath: 'assets/training/weights.png',
      ),
      _ExerciseData(
        title: 'Walking Lunges',
        kcal: '140 kcal',
        duration: '12 min',
        difficulty: 'Beginner',
        imagePath: 'assets/training/stretching.png',
      ),
      _ExerciseData(
        title: 'Leg Extensions',
        kcal: '120 kcal',
        duration: '10 min',
        difficulty: 'Beginner',
        imagePath: 'assets/training/kettlebell.png',
      ),
    ],
    'Back': [
      _ExerciseData(
        title: 'Lat Pulldown Workout',
        kcal: '130 kcal',
        duration: '12 min',
        difficulty: 'Medium',
        imagePath: 'assets/training/stretching.png',
      ),
      _ExerciseData(
        title: 'Bent Over Dumbbell Rows',
        kcal: '160 kcal',
        duration: '15 min',
        difficulty: 'Medium',
        imagePath: 'assets/training/weights.png',
      ),
      _ExerciseData(
        title: 'Deadlifts for Power',
        kcal: '200 kcal',
        duration: '10 min',
        difficulty: 'Advanced',
        imagePath: 'assets/training/kettlebell.png',
      ),
    ],
    'Chest': [
      _ExerciseData(
        title: 'Flat Bench Dumbbell Press',
        kcal: '145 kcal',
        duration: '15 min',
        difficulty: 'Beginner',
        imagePath: 'assets/training/weights.png',
      ),
      _ExerciseData(
        title: 'Incline Dumbbell Flys',
        kcal: '130 kcal',
        duration: '12 min',
        difficulty: 'Medium',
        imagePath: 'assets/training/weights.png',
      ),
      _ExerciseData(
        title: 'Standard Incline Push-ups',
        kcal: '100 kcal',
        duration: '8 min',
        difficulty: 'Beginner',
        imagePath: 'assets/training/stretching.png',
      ),
    ],
  };

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
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else if (widget.onBackTap != null) {
              widget.onBackTap!();
            }
          },
        ),
        title: Text(
          'FULL EXERCISE',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          // Category selector chips
          _buildCategoryTabs(isDark),
          const SizedBox(height: 16),
          // Exercise list
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: _buildExerciseList(isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(bool isDark) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: _categories.map((category) {
          final isSelected = category == _selectedCategory;
          Color tabBg;
          Color tabFg;

          if (isSelected) {
            tabBg = isDark ? Colors.white : Colors.black;
            tabFg = isDark ? Colors.black : Colors.white;
          } else {
            tabBg = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF3F4F6);
            tabFg = isDark ? Colors.white70 : const Color(0xFF6B7280);
          }

          return Container(
            margin: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: tabBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    color: tabFg,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildExerciseList(bool isDark) {
    final list = _exercises[_selectedCategory] ?? [];

    return ListView.separated(
      key: ValueKey<String>(_selectedCategory), // Unique key to trigger AnimatedSwitcher
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      separatorBuilder: (context, index) => const Divider(
        height: 16,
        color: Colors.transparent, // Blank separator space
      ),
      itemBuilder: (context, index) {
        final item = list[index];
        return ExerciseTile(
          title: item.title,
          kcal: item.kcal,
          duration: item.duration,
          difficulty: item.difficulty,
          imagePath: item.imagePath,
          onTap: () {
            // Future tap behavior
          },
        );
      },
    );
  }
}

class _ExerciseData {
  final String title;
  final String kcal;
  final String duration;
  final String difficulty;
  final String imagePath;

  const _ExerciseData({
    required this.title,
    required this.kcal,
    required this.duration,
    required this.difficulty,
    required this.imagePath,
  });
}
