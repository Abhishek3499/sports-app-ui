import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class VerificationCodeField extends StatefulWidget {
  const VerificationCodeField({
    super.key,
    this.length = 4,
    this.initialValue = '234',
  });

  final int length;
  final String initialValue;

  @override
  State<VerificationCodeField> createState() => _VerificationCodeFieldState();
}

class _VerificationCodeFieldState extends State<VerificationCodeField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Verification code',
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 1,
            height: 1,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              keyboardType: TextInputType.number,
              maxLength: widget.length,
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
              style: const TextStyle(color: Colors.transparent),
              cursorColor: Colors.transparent,
              onChanged: (_) => setState(() {}),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _focusNode.requestFocus(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.length, (index) {
                final hasValue = index < _controller.text.length;
                final isActive = index == _controller.text.length;
                final displayValue = hasValue ? _controller.text[index] : '';

                return Padding(
                  padding: EdgeInsets.only(
                    right: index == widget.length - 1 ? 0 : 17,
                  ),
                  child: _VerificationCodeBox(
                    value: displayValue,
                    isActive: isActive,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationCodeBox extends StatelessWidget {
  const _VerificationCodeBox({required this.value, required this.isActive});

  final String value;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43,
      height: 43,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isActive ? AppColors.inputFill : Colors.white,
        border: Border.all(
          color: isActive ? AppColors.inputBorder : AppColors.textPrimary,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: value.isEmpty
          ? Icon(Icons.circle, size: 7, color: AppColors.textSecondary)
          : Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 0,
              ),
            ),
    );
  }
}
