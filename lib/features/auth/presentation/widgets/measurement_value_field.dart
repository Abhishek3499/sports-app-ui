import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class MeasurementValueField extends StatelessWidget {
  const MeasurementValueField({
    super.key,
    required this.controller,
    required this.unit,
  });

  final TextEditingController controller;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 42,
              child: TextField(
                controller: controller,
                autofocus: true,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
                cursorColor: AppColors.textPrimary,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Container(width: 1, height: 14, color: AppColors.inputBorder),
            const SizedBox(width: 6),
            Text(
              unit.toLowerCase(),
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
