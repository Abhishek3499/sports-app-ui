import 'package:flutter/material.dart';

class MeasurementCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final double? progress;
  final bool isWorkout;

  const MeasurementCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    this.progress,
    this.isWorkout = false,
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
              child: isWorkout
                  ? _buildWorkoutContent(isDark)
                  : _buildCircularProgress(isDark),
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
            painter: _MeasurementProgressPainter(
              progress: progress ?? 0.0,
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

  Widget _buildWorkoutContent(bool isDark) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Stretching illustration
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Image.asset(
              'assets/training/stretching.png',
              fit: BoxFit.contain,
              color: isDark ? Colors.white70 : null,
              colorBlendMode: isDark ? BlendMode.modulate : null,
            ),
          ),
        ),
        const SizedBox(height: 4),
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
    );
  }
}

class _MeasurementProgressPainter extends CustomPainter {
  final double progress;
  final bool isDark;

  _MeasurementProgressPainter({
    required this.progress,
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
      ..color = isDark ? Colors.white : Colors.black
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
  bool shouldRepaint(covariant _MeasurementProgressPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isDark != isDark;
  }
}
