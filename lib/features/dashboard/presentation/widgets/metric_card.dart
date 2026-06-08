import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final double? progress; // If null, displays the waveform ECG chart
  final Color progressColor;

  const MetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    this.progress,
    this.progressColor = AppColors.lime,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Icon and Label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 20, color: isDark ? Colors.white70 : Colors.black87),
              ),
              Text(
                label,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Content Area
          Expanded(
            child: Center(
              child: progress != null
                  ? _buildCircularProgress(isDark)
                  : _buildWaveformContent(isDark),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress(bool isDark) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CustomPaint(
            painter: _CircularProgressPainter(
              progress: progress ?? 0.0,
              progressColor: progressColor,
              isDark: isDark,
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWaveformContent(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Waveform ECG Graphic
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(13, (index) {
            final heights = [
              18.0, 28.0, 42.0, 28.0, 18.0, 
              28.0, 42.0, 28.0, 18.0, 28.0, 
              42.0, 28.0, 18.0
            ];
            final height = index < heights.length ? heights[index] : 20.0;
            final isEven = index % 2 == 0;
            final barColor = isEven
                ? const Color(0xFFA5A05B) // Olive/khaki color
                : const Color(0xFFB3DE95); // Light green color
            return Container(
              width: 3.5,
              height: height,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        // Value and Subtitle below
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final bool isDark;

  _CircularProgressPainter({
    required this.progress,
    required this.progressColor,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 8) / 2;
    const strokeWidth = 8.0;

    final paintBackground = Paint()
      ..color = isDark ? const Color(0xFF2D2D2D) : const Color(0xFFE5E7EB)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final paintProgress = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw background track
    canvas.drawCircle(center, radius, paintBackground);

    // Draw active progress arc starting from the top (-pi/2)
    final sweepAngle = 2 * 3.1415926535 * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415926535 / 2,
      sweepAngle,
      false,
      paintProgress,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.isDark != isDark;
  }
}
