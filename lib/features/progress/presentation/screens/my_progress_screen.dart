import 'package:flutter/material.dart';
import '../widgets/activity_chart.dart';
import '../widgets/measurement_card.dart';

class MyProgressScreen extends StatefulWidget {
  const MyProgressScreen({super.key});

  @override
  State<MyProgressScreen> createState() => _MyProgressScreenState();
}

class _MyProgressScreenState extends State<MyProgressScreen> {
  String _selectedPeriod = 'Today';

  // Activity fractions for each period
  static const Map<String, List<double>> _chartData = {
    'Today': [0.6, 0.45, 0.9, 0.65, 0.85, 0.75, 0.72],
    'Week': [0.4, 0.65, 0.55, 0.8, 0.75, 0.9, 0.6],
    'Month': [0.75, 0.5, 0.8, 0.6, 0.95, 0.7, 0.85],
  };

  // Measurement items for each period
  static final Map<String, List<_MeasurementItem>> _measurements = {
    'Today': [
      const _MeasurementItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '2265',
        subtitle: 'Steps',
        progress: 0.32,
      ),
      const _MeasurementItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '8:50',
        subtitle: 'Hours',
        progress: 0.85,
      ),
      const _MeasurementItem(
        icon: Icons.self_improvement_rounded,
        label: 'Workout',
        value: '222',
        subtitle: 'Exercise',
        isWorkout: true,
      ),
      const _MeasurementItem(
        icon: Icons.whatshot_outlined,
        label: 'Calories',
        value: '399',
        subtitle: 'Kcal',
        progress: 0.45,
      ),
    ],
    'Week': [
      const _MeasurementItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '18450',
        subtitle: 'Steps',
        progress: 0.58,
      ),
      const _MeasurementItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '54:20',
        subtitle: 'Hours',
        progress: 0.72,
      ),
      const _MeasurementItem(
        icon: Icons.self_improvement_rounded,
        label: 'Workout',
        value: '14',
        subtitle: 'Exercise',
        isWorkout: true,
      ),
      const _MeasurementItem(
        icon: Icons.whatshot_outlined,
        label: 'Calories',
        value: '2800',
        subtitle: 'Kcal',
        progress: 0.62,
      ),
    ],
    'Month': [
      const _MeasurementItem(
        icon: Icons.directions_run_rounded,
        label: 'Walk',
        value: '78900',
        subtitle: 'Steps',
        progress: 0.82,
      ),
      const _MeasurementItem(
        icon: Icons.mode_night_outlined,
        label: 'Sleep',
        value: '220:10',
        subtitle: 'Hours',
        progress: 0.92,
      ),
      const _MeasurementItem(
        icon: Icons.self_improvement_rounded,
        label: 'Workout',
        value: '58',
        subtitle: 'Exercise',
        isWorkout: true,
      ),
      const _MeasurementItem(
        icon: Icons.whatshot_outlined,
        label: 'Calories',
        value: '12400',
        subtitle: 'Kcal',
        progress: 0.88,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chartValues = _chartData[_selectedPeriod] ?? [];
    final items = _measurements[_selectedPeriod] ?? [];

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
          'MY PROGRESS',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Activity Title
              Text(
                'Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              // Time Period Selectors
              Row(
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
              const SizedBox(height: 20),
              // Chart area
              ActivityChart(values: chartValues),
              const SizedBox(height: 28),
              // Measurement Title
              Text(
                'Measurement',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              // Grid list of Measurement cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.88,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return MeasurementCard(
                    icon: item.icon,
                    label: item.label,
                    value: item.value,
                    subtitle: item.subtitle,
                    progress: item.progress,
                    isWorkout: item.isWorkout,
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeasurementItem {
  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final double? progress;
  final bool isWorkout;

  const _MeasurementItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    this.progress,
    this.isWorkout = false,
  });
}
