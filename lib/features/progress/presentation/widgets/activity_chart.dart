import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ActivityChart extends StatelessWidget {
  final List<double> values; // List of 7 values between 0.0 and 1.0 (Mon to Sun)

  const ActivityChart({
    super.key,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      height: 220,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Stack(
        children: [
          // 1. Column Bars (Mon to Sun)
          Positioned.fill(
            bottom: 24, // Space for labels
            top: 25,    // Space for curve tops and glow ring headroom
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final isFriday = index == 4;
                final fraction = values[index];

                Color startColor;
                Color endColor;

                if (isFriday) {
                  startColor = const Color(0xFF98B319);
                  endColor = const Color(0xFFCBE03B);
                } else {
                  startColor = isDark ? const Color(0xFF242424) : const Color(0xFFCCCCCC);
                  endColor = isDark ? const Color(0xFF3E3E3E) : const Color(0xFFEFEFEF);
                }

                return FractionallySizedBox(
                  heightFactor: fraction,
                  child: Container(
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [startColor, endColor],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          // 2. Line Chart Overlay
          Positioned.fill(
            bottom: 24,
            top: 25,
            child: CustomPaint(
              painter: _ActivityLinePainter(
                values: values,
                isDark: isDark,
              ),
            ),
          ),
          // 3. Day Labels at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                return SizedBox(
                  width: 35,
                  child: Text(
                    dayLabels[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: index == 4 ? FontWeight.bold : FontWeight.w500,
                      color: index == 4
                          ? (isDark ? Colors.white : Colors.black87)
                          : Colors.grey,
                    ),
                    textAlign: TextAlign.center,
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

class _ActivityLinePainter extends CustomPainter {
  final List<double> values;
  final bool isDark;

  _ActivityLinePainter({
    required this.values,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 7) return;

    final double stepX = size.width / 7;
    double getX(int index) => (index + 0.5) * stepX;
    double getY(int index) => size.height * (1.0 - values[index]);

    // Extrapolate starting height at x = 0 (entry curve)
    final double yStart = getY(0) + (size.height - getY(0)) * 0.35;
    // Extrapolate ending height at x = size.width (exit curve)
    final double yEnd = getY(6);

    final List<Offset> points = [
      Offset(0, yStart),
      ...List.generate(7, (i) => Offset(getX(i), getY(i))),
      Offset(size.width, yEnd),
    ];

    // Compute tangents using Catmull-Rom formula (non-zero slopes at data points)
    final int n = points.length;
    List<Offset> tangents = List.filled(n, Offset.zero);
    const double tension = 0.5;

    for (int i = 0; i < n; i++) {
      if (i == 0) {
        tangents[i] = (points[1] - points[0]) * tension;
      } else if (i == n - 1) {
        tangents[i] = (points[n - 1] - points[n - 2]) * tension;
      } else {
        tangents[i] = (points[i + 1] - points[i - 1]) * tension;
      }
    }

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    // Draw cubic curves with calculated tangents
    for (int i = 0; i < n - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final t1 = tangents[i];
      final t2 = tangents[i + 1];

      final cp1 = p1 + t1 / 3;
      final cp2 = p2 - t2 / 3;

      path.cubicTo(
        cp1.dx, cp1.dy,
        cp2.dx, cp2.dy,
        p2.dx, p2.dy,
      );
    }

    final paintLine = Paint()
      ..color = AppColors.lime
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, paintLine);

    // Friday highlight dot (index 4)
    final double friX = getX(4);
    final double friY = getY(4);

    // 1. Large Outer Glow Ring (very transparent)
    final paintOuterGlow = Paint()
      ..color = AppColors.lime.withValues(alpha: 0.12)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(friX, friY), 24.0, paintOuterGlow);

    // 2. Middle Glow Ring (semi transparent)
    final paintMiddleGlow = Paint()
      ..color = AppColors.lime.withValues(alpha: 0.32)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(friX, friY), 15.0, paintMiddleGlow);

    // 3. Inner Solid Dot (AppColors.lime)
    final paintInnerDot = Paint()
      ..color = AppColors.lime
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(friX, friY), 7.5, paintInnerDot);

    // 4. Center Core Dot
    final paintCoreDot = Paint()
      ..color = const Color(0xFF869C13)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(friX, friY), 2.5, paintCoreDot);
  }

  @override
  bool shouldRepaint(covariant _ActivityLinePainter oldDelegate) {
    return oldDelegate.isDark != isDark || oldDelegate.values != values;
  }
}


