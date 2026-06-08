import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../categories/presentation/screens/categories_screen.dart';
import '../../../dashboard/presentation/screens/dashboard_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../progress/presentation/screens/my_progress_screen.dart';
import '../../../settings/presentation/screens/app_setting_screen.dart';
import '../../../training/presentation/screens/training_screen.dart';
import '../../../meals/presentation/screens/meal_plans_screen.dart';
import '../../../training/presentation/screens/full_exercise_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../../features/favorites/presentation/screens/my_favorites_screen.dart';
import '../../../settings/presentation/screens/contact_support_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _drawerAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _drawerAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleDrawer() {
    if (_controller.isDismissed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white, // Drawer background color
      body: Stack(
        children: [
          // 1. Drawer Menu
          _buildDrawer(),
          
          // 2. Main Screen Content (Animated)
          AnimatedBuilder(
            animation: _controller,
            child: GestureDetector(
              onTap: () {
                if (_controller.isCompleted) toggleDrawer();
              },
              child: Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                body: _buildCurrentBody(),
                bottomNavigationBar: _buildBottomNavigationBar(),
              ),
            ),
            builder: (context, child) {
              // Slide amount
              double slide = 250.0 * _drawerAnimation.value;
              // Scale down amount
              double scale = 1 - (_drawerAnimation.value * 0.2);
              
              return Transform(
                transform: Matrix4.translationValues(slide, 0.0, 0.0)
                  * Matrix4.diagonal3Values(scale, scale, 1.0),
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(_drawerAnimation.value * 40), // Round corners when scaled
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        if (_drawerAnimation.value > 0)
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          )
                      ],
                    ),
                    child: IgnorePointer(
                      // Ignore taps on main screen when drawer is open
                      ignoring: _controller.isCompleted, 
                      child: RepaintBoundary(
                        child: child,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentBody() {
    switch (_currentIndex) {
      case 0:
        return HomeContent(onMenuTap: toggleDrawer);
      case 1:
        return MealPlansScreen(onBackTap: () {
          HapticFeedback.lightImpact();
          setState(() {
            _currentIndex = 0;
          });
        });
      case 2:
        return FullExerciseScreen(onBackTap: () {
          HapticFeedback.lightImpact();
          setState(() {
            _currentIndex = 0;
          });
        });
      case 3:
        return ProfileScreen(onBackTap: () {
          HapticFeedback.lightImpact();
          setState(() {
            _currentIndex = 0;
          });
        });
      default:
        return HomeContent(onMenuTap: toggleDrawer);
    }
  }

  Widget _buildBottomNavigationBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      selectedItemColor: isDark ? Colors.white : Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      currentIndex: _currentIndex,
      onTap: (index) {
        HapticFeedback.lightImpact();
        setState(() {
          _currentIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu), label: 'Meal Plans'),
        BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Exercise'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }

  Widget _buildDrawer() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.white10 : Colors.black12;

    return SafeArea(
      child: Container(
        width: 250,
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.close, size: 30, color: isDark ? Colors.white : Colors.black),
              onPressed: toggleDrawer,
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: isDark ? const Color(0xFF2C2C2C) : Colors.grey[300],
                    child: Icon(Icons.person, color: isDark ? Colors.white54 : Colors.grey, size: 40),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Dhruvit !', 
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Basic member', style: TextStyle(color: Colors.grey, fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildDrawerItem(Icons.dashboard_outlined, 'Dashboard'),
                  Divider(height: 1, color: dividerColor),
                  _buildDrawerItem(Icons.show_chart, 'My Progress'),
                  Divider(height: 1, color: dividerColor),
                  _buildDrawerItem(Icons.fitness_center, 'Traning'),
                  Divider(height: 1, color: dividerColor),
                  _buildDrawerItem(Icons.category_outlined, 'Categories'),
                  Divider(height: 1, color: dividerColor),
                  _buildDrawerItem(Icons.notifications_none, 'Notification'),
                  Divider(height: 1, color: dividerColor),
                  _buildDrawerItem(Icons.favorite_border, 'My Favorites'),
                  Divider(height: 1, color: dividerColor),
                  _buildDrawerItem(Icons.settings_outlined, 'App Settings'),
                  Divider(height: 1, color: dividerColor),
                  _buildDrawerItem(Icons.support_agent_outlined, 'Contact Support'),
                  Divider(height: 1, color: dividerColor),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: isDark ? Colors.white : Colors.black),
              title: Text(
                'Sign Out', 
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                // Handle sign out
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      leading: Icon(icon, color: isDark ? Colors.white70 : Colors.black54),
      title: Text(
        title, 
        style: TextStyle(
          fontSize: 14,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      onTap: () {
        HapticFeedback.lightImpact();
        toggleDrawer(); // Close the drawer
        if (title == 'Dashboard') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        } else if (title == 'Traning') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const TrainingScreen()),
          );
        } else if (title == 'Categories') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CategoriesScreen()),
          );
        } else if (title == 'Notification') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NotificationsScreen()),
          );
        } else if (title == 'My Favorites') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MyFavoritesScreen()),
          );
        } else if (title == 'App Settings') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AppSettingScreen()),
          );
        } else if (title == 'My Progress') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MyProgressScreen()),
          );
        } else if (title == 'Contact Support') {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ContactSupportScreen()),
          );
        }
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  final VoidCallback onMenuTap;
  
  const HomeContent({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildBanner(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'SELECT YOUR GOAL'),
            _buildGoalsList(context),
            const SizedBox(height: 24),
            _buildSectionTitle(
              context,
              'CATEGORY',
              seeAll: true,
              onSeeAllTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                );
              },
            ),
            _buildCategories(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'POPULAR EXERCISE', seeAll: true),
            _buildPopularExercises(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'MEAL PLANS', seeAll: true),
            _buildMealPlans(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'ADDITIONAL EXERCISE', seeAll: true),
            _buildAdditionalExercises(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.lime,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: onMenuTap,
                    child: const Icon(Icons.menu, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[300],
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                      );
                    },
                    child: const Icon(Icons.notifications_none, color: Colors.white),
                  ),
                  const SizedBox(width: 4),
                  Theme(
                    data: Theme.of(context).copyWith(
                      cardColor: Theme.of(context).brightness == Brightness.dark
                          ? const Color(0xFF1E1E1E)
                          : Colors.white,
                    ),
                    child: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      position: PopupMenuPosition.under,
                      elevation: 4,
                      shadowColor: Colors.black.withValues(alpha: 0.15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onSelected: (value) {
                        HapticFeedback.lightImpact();
                        if (value == 'notification') {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                          );
                        } else if (value == 'progress') {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const MyProgressScreen()),
                          );
                        } else if (value == 'favorites') {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const MyFavoritesScreen()),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        final isDark = Theme.of(context).brightness == Brightness.dark;
                        return [
                          PopupMenuItem<String>(
                            value: 'notification',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.notifications_none_outlined,
                                  color: isDark ? Colors.white70 : Colors.black87,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'Notification',
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'progress',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.show_chart_rounded,
                                  color: isDark ? Colors.white70 : Colors.black87,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'My Progress',
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuItem<String>(
                            value: 'favorites',
                            child: Row(
                              children: [
                                Icon(
                                  Icons.favorite_border_rounded,
                                  color: isDark ? Colors.white70 : Colors.black87,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  'My Favorites',
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Hello, Good Morning', style: TextStyle(color: Colors.white, fontSize: 14)),
          const Text('Dhruvit !', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.grey),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 140,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                ),
                child: const Center(child: Icon(Icons.image, color: Colors.white, size: 50)),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('FIT YOUNG MAN DOING BATTLE STRETCH TRAINING', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(100, 30),
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {},
                      child: const Text('Start Exercise', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, {bool seeAll = false, VoidCallback? onSeeAllTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title, 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 14,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          if (seeAll)
            GestureDetector(
              onTap: onSeeAllTap,
              child: Text(
                'See all', 
                style: TextStyle(
                  fontSize: 12, 
                  fontWeight: FontWeight.bold, 
                  color: isDark ? Colors.white70 : Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGoalsList(BuildContext context) {
    final goals = ['Loose Weight', 'Gain Weight', 'Body Building', 'Healthy'];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: goals.length,
          itemBuilder: (context, index) {
            bool isSelected = index == 1;
            return Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected 
                  ? (isDark ? Colors.white : Colors.black) 
                  : (isDark ? const Color(0xFF2C2C2C) : Colors.grey[200]),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                goals[index],
                style: TextStyle(
                  color: isSelected 
                    ? (isDark ? Colors.black : Colors.white) 
                    : (isDark ? Colors.white70 : Colors.black),
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {'title': 'Yoga', 'image': 'assets/select_your_fav/yoga.png'},
      {'title': 'Gym', 'image': 'assets/training/weights.png'},
      {'title': 'Cardio', 'image': 'assets/select_your_fav/running.png'},
      {'title': 'Stretch', 'image': 'assets/training/stretching.png'},
      {'title': 'Full Body', 'image': 'assets/training/jumprope.png'},
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage(categories[index]['image']!),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      categories[index]['title']!, 
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
    );
  }

  Widget _buildPopularExercises(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
      child: Column(
        children: [
          _buildExerciseCard(context, 'Full Shot Man Stretching Arm', 'Beginner', '30 Min'),
          const SizedBox(height: 16),
          _buildExerciseCard(context, 'Athlete Practicing Monochrone', 'Beginner', '50 Min'),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(BuildContext context, String title, String level, String time) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), spreadRadius: 1, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2D2D2D) : Colors.grey[300],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: const Center(child: Icon(Icons.image, color: Colors.white24, size: 50)),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: CircleAvatar(
                  backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                  radius: 14,
                  child: Icon(Icons.favorite, color: Colors.red[300], size: 16),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 14,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      level, 
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const Text(' | ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const Icon(Icons.access_time, size: 12, color: Colors.lightBlue),
                    const SizedBox(width: 4),
                    Text(
                      time, 
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlans(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
      child: Column(
        children: [
          _buildMealCard(context, 'Greek salad with lettuce, green onion', '150 kcal'),
          const SizedBox(height: 16),
          _buildMealCard(context, 'Salad of fresh vegetables', '270 kcal', color: const Color(0xFFE0F7FA)),
        ],
      ),
    );
  }

  Widget _buildMealCard(BuildContext context, String title, String calories, {Color color = const Color(0xFFFDE9F1)}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 140,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Icon(
              Icons.image, 
              color: isDark ? Colors.white24 : Colors.black26, 
              size: 40,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title, 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 12,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        Text(calories, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }

  Widget _buildAdditionalExercises(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
      child: Column(
        children: [
          _buildAdditionalExerciseTile(context, 'Exercises with Jumping Rope', '110 kcal', '10 min', 'Beginner', Colors.amber),
          const SizedBox(height: 16),
          _buildAdditionalExerciseTile(context, 'Exercises with Holding Jumping Rope', '120 kcal', '8 min', 'Beginner', Colors.cyan),
          const SizedBox(height: 16),
          _buildAdditionalExerciseTile(context, 'Exercises with Sitting Dumbbells', '120 kcal', '5 min', 'Beginner', Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildAdditionalExerciseTile(BuildContext context, String title, String kcal, String time, String level, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Icon(Icons.image, color: Colors.white)),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title, 
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 12,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.local_fire_department, size: 12, color: Colors.lightBlue),
                  const SizedBox(width: 4),
                  Text(kcal, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                  const Text(' | ', style: TextStyle(color: Colors.grey, fontSize: 10)),
                  const Icon(Icons.access_time, size: 12, color: Colors.lightBlue),
                  const SizedBox(width: 4),
                  Text(time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
                ],
              ),
              const SizedBox(height: 4),
              Text(level, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }
}

class UnderConstructionView extends StatelessWidget {
  final String title;
  final VoidCallback onMenuTap;

  const UnderConstructionView({
    super.key,
    required this.title,
    required this.onMenuTap,
  });

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
          icon: Icon(Icons.menu, color: isDark ? Colors.white : Colors.black),
          onPressed: onMenuTap,
        ),
        title: Text(
          title.toUpperCase(),
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              title == 'Meal Plans' ? Icons.restaurant_menu : Icons.person_outline,
              size: 80,
              color: AppColors.lime.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              '$title Screen',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'This screen is coming soon!',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
