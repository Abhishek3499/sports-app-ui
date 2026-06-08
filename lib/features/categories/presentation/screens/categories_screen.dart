import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/category_model.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _searchQuery = '';

  static const List<CategoryModel> _categories = [
    CategoryModel(
      title: 'Yoga',
      imagePath: 'assets/select_your_fav/yoga.png',
    ),
    CategoryModel(
      title: 'Gym',
      imagePath: 'assets/training/weights.png',
    ),
    CategoryModel(
      title: 'Cardio',
      imagePath: 'assets/select_your_fav/running.png',
    ),
    CategoryModel(
      title: 'Stretch',
      imagePath: 'assets/training/stretching.png',
    ),
    CategoryModel(
      title: 'Full Body',
      imagePath: 'assets/training/jumprope.png',
    ),
    CategoryModel(
      title: 'Legs',
      imagePath: 'assets/select_your_fav/walking.png',
    ),
  ];

  List<CategoryModel> get _filteredCategories {
    if (_searchQuery.isEmpty) {
      return _categories;
    }
    return _categories
        .where((category) =>
            category.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

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
          icon: Icon(Icons.chevron_left, size: 32, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'CATEGORIES',
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
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2C2C2C) : AppColors.inputFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Grid View of Categories
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _filteredCategories.isEmpty
                  ? const Center(
                      child: Text(
                        'No categories found.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.only(bottom: 24),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 24,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: _filteredCategories.length,
                      itemBuilder: (context, index) {
                        final category = _filteredCategories[index];
                        return CategoryGridItem(
                          category: category,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${category.title} exercises coming soon!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
