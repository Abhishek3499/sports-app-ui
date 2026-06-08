import 'package:flutter/material.dart';

class ExerciseTile extends StatelessWidget {
  final String title;
  final String kcal;
  final String duration;
  final String difficulty;
  final String imagePath;
  final VoidCallback? onTap;

  const ExerciseTile({
    super.key,
    required this.title,
    required this.kcal,
    required this.duration,
    required this.difficulty,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF3F4F6),
                    child: Icon(
                      Icons.fitness_center,
                      color: isDark ? Colors.white54 : Colors.grey,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  // Title
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Metadata (kcal & time)
                  Row(
                    children: [
                      Icon(
                        Icons.local_fire_department_outlined,
                        size: 14,
                        color: isDark ? Colors.white54 : Colors.black54,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        kcal,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const Text(
                        '  |  ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: isDark ? Colors.white54 : Colors.black54,
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
                  const SizedBox(height: 6),
                  // Difficulty
                  Text(
                    difficulty,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
