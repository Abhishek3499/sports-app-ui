import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class AgeWheelPicker extends StatefulWidget {
  const AgeWheelPicker({
    super.key,
    this.minAge = 5,
    this.maxAge = 90,
    this.initialAge = 27,
  });

  final int minAge;
  final int maxAge;
  final int initialAge;

  @override
  State<AgeWheelPicker> createState() => _AgeWheelPickerState();
}

class _AgeWheelPickerState extends State<AgeWheelPicker> {
  late final FixedExtentScrollController _controller;
  late int _selectedAge;

  @override
  void initState() {
    super.initState();
    _selectedAge = widget.initialAge.clamp(widget.minAge, widget.maxAge);
    _controller = FixedExtentScrollController(
      initialItem: _selectedAge - widget.minAge,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ageCount = widget.maxAge - widget.minAge + 1;

    return SizedBox(
      height: 350,
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        itemExtent: 36,
        diameterRatio: 100,
        perspective: 0.001,
        squeeze: 0.96,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() => _selectedAge = widget.minAge + index);
        },
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: ageCount,
          builder: (context, index) {
            final age = widget.minAge + index;
            final isSelected = age == _selectedAge;
            final distanceFromSelected = (age - _selectedAge).abs();
            final opacity = switch (distanceFromSelected) {
              0 => 1.0,
              1 => 0.72,
              2 => 0.46,
              _ => 0.24,
            };

            return Center(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _selectAge(index),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 160),
                  opacity: opacity,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: isSelected ? 45 : 56,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.textPrimary : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      '$age',
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontSize: isSelected ? 13 : 12,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _selectAge(int index) {
    setState(() => _selectedAge = widget.minAge + index);
    _controller.animateToItem(
      index,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
    );
  }
}
