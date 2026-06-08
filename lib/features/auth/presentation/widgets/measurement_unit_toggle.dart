import 'package:flutter/material.dart';
import 'package:sports_app/core/constants/app_colors.dart';

class MeasurementUnitToggle extends StatelessWidget {
  const MeasurementUnitToggle({
    super.key,
    required this.units,
    required this.selectedUnit,
    required this.onUnitSelected,
  });

  final List<String> units;
  final String selectedUnit;
  final ValueChanged<String> onUnitSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 120,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Row(
        children: units.map((unit) {
          final isSelected = unit == selectedUnit;

          return Expanded(
            child: GestureDetector(
              onTap: () => onUnitSelected(unit),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  unit,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 11,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
