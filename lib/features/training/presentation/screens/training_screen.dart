import 'package:flutter/material.dart';
import '../widgets/difficulty_tabs.dart';
import '../widgets/popular_training_card.dart';
import '../widgets/just_for_you_card.dart';

class TrainingScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const TrainingScreen({super.key, this.onBackTap});

  @override
  State<TrainingScreen> createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  String _selectedDifficulty = 'Beginner';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32, color: isDark ? Colors.white : Colors.black),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else if (widget.onBackTap != null) {
              widget.onBackTap!();
            }
          },
        ),
        title: Text(
          'TRAINING',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined, color: isDark ? Colors.white : Colors.black, size: 28),
            onPressed: () {
              // Handle filter action
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Difficulty Tabs
              DifficultyTabs(
                selectedDifficulty: _selectedDifficulty,
                onDifficultyChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value;
                  });
                },
              ),
              const SizedBox(height: 28),
              // Popular Training Section
              Text(
                'Popular Training',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              PopularTrainingCard(
                title: 'Full Shot Woman Stretching Arm',
                difficulty: 'Beginner',
                duration: '30 min',
                imagePath: 'assets/training/stretching.png',
                isFavorite: true,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              PopularTrainingCard(
                title: 'Athlete Practicing Claps hands Arm Balance',
                difficulty: 'Beginner',
                duration: '50 min',
                imagePath: 'assets/training/kettlebell.png',
                isLocked: true,
                onTap: () {},
              ),
              const SizedBox(height: 20),
              PopularTrainingCard(
                title: 'Athlete Practicing Monochrome',
                difficulty: 'Beginner',
                duration: '20 min',
                imagePath: 'assets/training/tennis.png',
                isFavorite: true,
                onTap: () {},
              ),
              const SizedBox(height: 28),
              // Just for you Section
              Text(
                'Just for you',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 170,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    JustForYouCard(
                      title: 'Be Free',
                      duration: '20 min',
                      imagePath: 'assets/training/jumprope.png',
                    ),
                    JustForYouCard(
                      title: 'Energym',
                      duration: '20 min',
                      imagePath: 'assets/training/weights.png',
                    ),
                    JustForYouCard(
                      title: 'Be Free',
                      duration: '20 min',
                      imagePath: 'assets/training/jumprope.png',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
