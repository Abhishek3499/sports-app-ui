import 'package:flutter/material.dart';

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 8, 25, 0),
                child: child,
              ),
            ),
          );
        },
      ),
    );
  }
}
