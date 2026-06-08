import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MealPlansScreen extends StatefulWidget {
  final VoidCallback? onBackTap;

  const MealPlansScreen({super.key, this.onBackTap});

  @override
  State<MealPlansScreen> createState() => _MealPlansScreenState();
}

class _MealPlansScreenState extends State<MealPlansScreen> {
  String _selectedCategory = 'Weight Loss';
  final List<String> _categories = ['Weight Loss', 'Muscle Gain', 'Keto', 'Healthy'];

  // Static mock meal plans per category
  static const Map<String, List<_MealPlanData>> _mealPlans = {
    'Weight Loss': [
      _MealPlanData(
        title: 'Greek salad with lettuce, green onion',
        description: 'Low calorie, fresh, rich in vitamins and dietary fibers.',
        kcal: '150 kcal',
        duration: '7 Days',
        mealsCount: '3 meals/day',
        imagePath: 'assets/select_your_fav/meal.png',
        imageUrl: 'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=800&q=80',
        color: Color(0xFFFDE9F1),
      ),
      _MealPlanData(
        title: 'Salad of fresh vegetables',
        description: 'Clean eating option containing fresh cucumbers, tomatoes, and olive oil dressing.',
        kcal: '270 kcal',
        duration: '14 Days',
        mealsCount: '3 meals/day',
        imagePath: 'assets/select_your_fav/meal.png',
        imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?auto=format&fit=crop&w=800&q=80',
        color: Color(0xFFE0F7FA),
      ),
    ],
    'Muscle Gain': [
      _MealPlanData(
        title: 'High Protein Chicken and Quinoa Bowl',
        description: 'Packed with lean grilled chicken breast, organic quinoa, and steamed broccoli.',
        kcal: '540 kcal',
        duration: '30 Days',
        mealsCount: '4 meals/day',
        imagePath: 'assets/select_your_fav/meal.png',
        imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?auto=format&fit=crop&w=800&q=80',
        color: Color(0xFFFFF3E0),
      ),
      _MealPlanData(
        title: 'Steak and Roasted Sweet Potatoes',
        description: 'Premium beef steak with seasoned roasted sweet potato chunks for complex carbs.',
        kcal: '620 kcal',
        duration: '14 Days',
        mealsCount: '4 meals/day',
        imagePath: 'assets/select_your_fav/meal.png',
        imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80',
        color: Color(0xFFF1F8E9),
      ),
    ],
    'Keto': [
      _MealPlanData(
        title: 'Avocado Egg Salad with Bacon',
        description: 'Healthy fats from fresh avocado, hard-boiled organic eggs, and crispy sugar-free bacon.',
        kcal: '420 kcal',
        duration: '7 Days',
        mealsCount: '3 meals/day',
        imagePath: 'assets/select_your_fav/meal.png',
        imageUrl: 'https://images.unsplash.com/photo-1522244451342-a41bf8a13d73?auto=format&fit=crop&w=800&q=80',
        color: Color(0xFFEDE7F6),
      ),
    ],
    'Healthy': [
      _MealPlanData(
        title: 'Oatmeal with Mixed Berries & Almonds',
        description: 'Slow-digesting complex carbs topped with fresh blueberries, strawberries, and almonds.',
        kcal: '320 kcal',
        duration: '30 Days',
        mealsCount: '3 meals/day',
        imagePath: 'assets/select_your_fav/meal.png',
        imageUrl: 'https://images.unsplash.com/photo-1517881917430-e70dfb3610aa?auto=format&fit=crop&w=800&q=80',
        color: Color(0xFFE8F5E9),
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
            HapticFeedback.lightImpact();
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else if (widget.onBackTap != null) {
              widget.onBackTap!();
            }
          },
        ),
        title: Text(
          'MEAL PLANS',
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
          // Category chips selector
          _buildCategoryChips(isDark),
          const SizedBox(height: 16),
          // Scrollable Meal Plan List
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return FadeTransition(opacity: animation, child: child);
              },
              child: _buildMealPlanList(isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(bool isDark) {
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
                HapticFeedback.lightImpact();
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

  Widget _buildMealPlanList(bool isDark) {
    final list = _mealPlans[_selectedCategory] ?? [];

    return ListView.separated(
      key: ValueKey<String>(_selectedCategory),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      separatorBuilder: (context, index) => const SizedBox(height: 20),
      itemBuilder: (context, index) {
        final item = list[index];

        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image card container
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  height: 160,
                  width: double.infinity,
                  color: isDark ? const Color(0xFF1E1E1E) : item.color,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const _MealImageShimmer();
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Image.asset(
                          item.imagePath,
                          height: 100,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.restaurant_menu_rounded,
                              size: 50,
                              color: isDark ? Colors.white24 : Colors.black26,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Title text
              Text(
                item.title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              // Description
              Text(
                item.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 6),
              // Metadata Row (kcal, duration, mealsCount)
              Row(
                children: [
                  Icon(
                    Icons.local_fire_department_outlined,
                    size: 14,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.kcal,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const Text('  |  ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 13,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.duration,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const Text('  |  ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Icon(
                    Icons.restaurant_rounded,
                    size: 13,
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.mealsCount,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MealPlanData {
  final String title;
  final String description;
  final String kcal;
  final String duration;
  final String mealsCount;
  final String imagePath;
  final String imageUrl;
  final Color color;

  const _MealPlanData({
    required this.title,
    required this.description,
    required this.kcal,
    required this.duration,
    required this.mealsCount,
    required this.imagePath,
    required this.imageUrl,
    required this.color,
  });
}

class _MealImageShimmer extends StatefulWidget {
  const _MealImageShimmer();

  @override
  State<_MealImageShimmer> createState() => _MealImageShimmerState();
}

class _MealImageShimmerState extends State<_MealImageShimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return FadeTransition(
      opacity: _animation,
      child: Container(
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE5E7EB),
        child: const Center(
          child: Icon(
            Icons.restaurant_menu_rounded,
            size: 40,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
