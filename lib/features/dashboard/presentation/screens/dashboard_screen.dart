import 'package:flutter/material.dart';
import '../widgets/metric_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedPeriod = 'Today';

  // Metrics Data structure
  static final Map<String, List<_MetricItem>> _periodMetrics = {
    'Today': [
      const _MetricItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '2265',
        subtitle: 'Steps',
        progress: 0.32,
      ),
      const _MetricItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '8:50',
        subtitle: 'Hours',
        progress: 0.85,
      ),
      const _MetricItem(
        icon: Icons.favorite_border_rounded,
        label: 'Heart',
        value: '115',
        subtitle: 'bmp',
        progress: null, // Displays ECG waveform
      ),
      const _MetricItem(
        icon: Icons.whatshot_outlined,
        label: 'Calories',
        value: '399',
        subtitle: 'Kcal',
        progress: 0.45,
      ),
      const _MetricItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '2265',
        subtitle: 'Steps',
        progress: 0.32,
      ),
      const _MetricItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '8:50',
        subtitle: 'Hours',
        progress: 0.85,
      ),
    ],
    'Week': [
      const _MetricItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '18450',
        subtitle: 'Steps',
        progress: 0.58,
      ),
      const _MetricItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '54:20',
        subtitle: 'Hours',
        progress: 0.72,
      ),
      const _MetricItem(
        icon: Icons.favorite_border_rounded,
        label: 'Heart',
        value: '78',
        subtitle: 'bmp',
        progress: null,
      ),
      const _MetricItem(
        icon: Icons.whatshot_outlined,
        label: 'Calories',
        value: '2800',
        subtitle: 'Kcal',
        progress: 0.62,
      ),
      const _MetricItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '18450',
        subtitle: 'Steps',
        progress: 0.58,
      ),
      const _MetricItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '54:20',
        subtitle: 'Hours',
        progress: 0.72,
      ),
    ],
    'Month': [
      const _MetricItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '78900',
        subtitle: 'Steps',
        progress: 0.82,
      ),
      const _MetricItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '220:10',
        subtitle: 'Hours',
        progress: 0.92,
      ),
      const _MetricItem(
        icon: Icons.favorite_border_rounded,
        label: 'Heart',
        value: '72',
        subtitle: 'bmp',
        progress: null,
      ),
      const _MetricItem(
        icon: Icons.whatshot_outlined,
        label: 'Calories',
        value: '12400',
        subtitle: 'Kcal',
        progress: 0.88,
      ),
      const _MetricItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '78900',
        subtitle: 'Steps',
        progress: 0.82,
      ),
      const _MetricItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '220:10',
        subtitle: 'Hours',
        progress: 0.92,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final metrics = _periodMetrics[_selectedPeriod] ?? [];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: 32, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'DASHBOARD',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Time Period Filter Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: ['Today', 'Week', 'Month'].map((period) {
                final isSelected = period == _selectedPeriod;
                Color tabBg;
                Color tabFg;
                if (isSelected) {
                  tabBg = isDark ? Colors.white : Colors.black;
                  tabFg = isDark ? Colors.black : Colors.white;
                } else {
                  tabBg = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF3F4F6);
                  tabFg = isDark ? Colors.white70 : const Color(0xFF4B5563);
                }

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedPeriod = period;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: tabBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          period,
                          style: TextStyle(
                            color: tabFg,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 12),
          // Metric Cards Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.88,
              ),
              itemCount: metrics.length,
              itemBuilder: (context, index) {
                final item = metrics[index];
                return MetricCard(
                  icon: item.icon,
                  label: item.label,
                  value: item.value,
                  subtitle: item.subtitle,
                  progress: item.progress,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricItem {
  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final double? progress;

  const _MetricItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    this.progress,
  });
}
