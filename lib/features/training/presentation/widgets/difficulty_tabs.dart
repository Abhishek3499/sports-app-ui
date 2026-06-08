import 'package:flutter/material.dart';

class DifficultyTabs extends StatelessWidget {
  final String selectedDifficulty;
  final ValueChanged<String> onDifficultyChanged;

  const DifficultyTabs({
    super.key,
    required this.selectedDifficulty,
    required this.onDifficultyChanged,
  });

  @override
  Widget build(BuildContext context) {
    final difficulties = ['Beginner', 'Intermediate', 'Advanced'];
    return Row(
      children: difficulties.map((difficulty) {
        final isSelected = difficulty == selectedDifficulty;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () => onDifficultyChanged(difficulty),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  difficulty,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
