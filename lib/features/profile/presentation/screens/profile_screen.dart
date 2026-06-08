import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onBackTap;

  const ProfileScreen({super.key, this.onBackTap});

  // Goal category list
  static const List<Map<String, String>> _goals = [
    {'title': 'Yoga', 'image': 'assets/select_your_fav/yoga.png'},
    {'title': 'Gym', 'image': 'assets/training/weights.png'},
    {'title': 'Cardio', 'image': 'assets/select_your_fav/running.png'},
    {'title': 'Stretch', 'image': 'assets/training/stretching.png'},
    {'title': 'Full Body', 'image': 'assets/training/jumprope.png'},
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
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else if (onBackTap != null) {
              onBackTap!();
            }
          },
        ),
        title: Text(
          'PROFILE',
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
            icon: Icon(
              Icons.edit_outlined,
              size: 24,
              color: isDark ? Colors.white : Colors.black87,
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Avatar Image
            Center(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black12,
                    width: 1,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/onboading/strong_man.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[200],
                            child: Icon(
                              Icons.person,
                              size: 50,
                              color: isDark ? Colors.white54 : Colors.grey,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // User Name and Status
            Center(
              child: Column(
                children: [
                  Text(
                    'DHRUVIT !',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Basic member',
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white70 : Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            // Stats row (Weight, Height, Age)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('55', 'kg', 'Weight', isDark),
                  _buildVerticalSeparator(isDark),
                  _buildStatColumn('170', 'cm', 'Height', isDark),
                  _buildVerticalSeparator(isDark),
                  _buildStatColumn('18', 'year', 'Age', isDark),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Goal Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Goal',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Horizontal scroll list of goals
            SizedBox(
              height: 95,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goal = _goals[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                      },
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey[200],
                            backgroundImage: AssetImage(goal['image']!),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            goal['title']!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white70 : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            // Macronutrient Goals Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'MACRONUTRIENT GOALS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Macronutrient list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  _buildMacroItem(
                    context: context,
                    imageUrl: 'https://images.unsplash.com/photo-1551754625-70c90487530d?w=150',
                    label: 'Protein',
                    amount: '130',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 14),
                  _buildMacroItem(
                    context: context,
                    imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?w=150',
                    label: 'Carbs',
                    amount: '235',
                    isDark: isDark,
                  ),
                  const SizedBox(width: 14),
                  _buildMacroItem(
                    context: context,
                    imageUrl: 'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=150',
                    label: 'Fat',
                    amount: '60',
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String number, String unit, String label, bool isDark) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 2),
            Text(
              unit,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalSeparator(bool isDark) {
    return Container(
      width: 1,
      height: 24,
      color: isDark ? Colors.white12 : Colors.black12,
    );
  }

  Widget _buildMacroItem({
    required BuildContext context,
    required String imageUrl,
    required String label,
    required String amount,
    required bool isDark,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
        },
        child: Column(
          children: [
            // Food Image with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/select_your_fav/meal.png',
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 80,
                        width: double.infinity,
                        color: isDark ? const Color(0xFF2C2C2C) : Colors.grey[200],
                        child: Icon(
                          Icons.restaurant_rounded,
                          color: isDark ? Colors.white30 : Colors.black26,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Label
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            // Amount
            Text(
              amount,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 2),
            // Subtitle
            const Text(
              'Grams per day',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
