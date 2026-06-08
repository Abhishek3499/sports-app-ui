import 'package:flutter/material.dart';

import 'auth_screen_body.dart';
import 'auth_step_header.dart';
import 'login_primary_button.dart';
import 'measurement_unit_toggle.dart';
import 'measurement_value_field.dart';

class MeasurementStepBody extends StatefulWidget {
  const MeasurementStepBody({
    super.key,
    required this.stepLabel,
    required this.title,
    required this.units,
    required this.initialUnit,
    required this.initialValue,
    required this.onNextPressed,
  });

  final String stepLabel;
  final String title;
  final List<String> units;
  final String initialUnit;
  final String initialValue;
  final VoidCallback onNextPressed;

  @override
  State<MeasurementStepBody> createState() => _MeasurementStepBodyState();
}

class _MeasurementStepBodyState extends State<MeasurementStepBody> {
  late final TextEditingController _valueController;
  late String _selectedUnit;

  @override
  void initState() {
    super.initState();
    _valueController = TextEditingController(text: widget.initialValue);
    _selectedUnit = widget.initialUnit;
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthStepHeader(
            stepLabel: widget.stepLabel,
            title: widget.title,
            onBackPressed: () => Navigator.of(context).maybePop(),
            onSkipPressed: () {},
          ),
          const SizedBox(height: 96),
          Center(
            child: MeasurementUnitToggle(
              units: widget.units,
              selectedUnit: _selectedUnit,
              onUnitSelected: (unit) => setState(() => _selectedUnit = unit),
            ),
          ),
          const SizedBox(height: 14),
          MeasurementValueField(
            controller: _valueController,
            unit: _selectedUnit,
          ),
          const SizedBox(height: 110),
          LoginPrimaryButton(
            label: 'NEXT STEPS',
            onPressed: widget.onNextPressed,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
