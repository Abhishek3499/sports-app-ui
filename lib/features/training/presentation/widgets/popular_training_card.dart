import 'package:flutter/material.dart';

class PopularTrainingCard extends StatelessWidget {
  final String title;
  final String difficulty;
  final String duration;
  final String imagePath;
  final bool isLocked;
  final bool isFavorite;
  final VoidCallback? onTap;

  const PopularTrainingCard({
    super.key,
    required this.title,
    required this.difficulty,
    required this.duration,
    required this.imagePath,
    this.isLocked = false,
    this.isFavorite = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container with badge
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (isFavorite || isLocked)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    child: isLocked
                        ? Icon(
                            Icons.lock_rounded,
                            size: 16,
                            color: isDark ? Colors.white70 : Colors.black87,
                          )
                        : const Icon(
                            Icons.favorite,
                            size: 16,
                            color: Colors.redAccent,
                          ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          // Metadata
          Row(
            children: [
              Text(
                difficulty,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '  |  ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
              const Icon(
                Icons.access_time,
                size: 14,
                color: Colors.cyan,
              ),
              const SizedBox(width: 4),
              Text(
                duration,
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
  }
}
