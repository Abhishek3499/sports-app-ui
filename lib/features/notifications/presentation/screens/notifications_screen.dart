import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  static const List<_NotificationItem> _notifications = [
    _NotificationItem(
      title: 'Daily steps goal completed',
      details: 'Steps : 10000',
      time: '15 mins ago',
    ),
    _NotificationItem(
      title: 'Today you have an average of 71 bpm. it is very well keep it up.',
      details: null,
      time: '50 mins ago',
    ),
    _NotificationItem(
      title: 'Congratulations',
      details: 'Steps : 10000',
      time: '15 mins ago',
    ),
    _NotificationItem(
      title: 'Today you have an average of 71 bpm. it is very well keep it up.',
      details: null,
      time: '50 mins ago',
    ),
    _NotificationItem(
      title: 'Congratulations',
      details: 'Steps : 10000',
      time: '55 mins ago',
    ),
    _NotificationItem(
      title: 'Today you have an average of 71 bpm. it is very well keep it up.',
      details: null,
      time: '50 mins ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 32,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'NOTIFICATIONS',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: _notifications.length,
        separatorBuilder: (context, index) => const Divider(
          height: 1,
          color: Color(0xFFEEEEEE),
        ),
        itemBuilder: (context, index) {
          final item = _notifications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dumbbell circle icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.lime.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.fitness_center,
                      color: AppColors.lime,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Notification Text details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white70 : Colors.black87,
                          height: 1.25,
                        ),
                      ),
                      if (item.details != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          item.details!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      const SizedBox(height: 6),
                      Text(
                        item.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _NotificationItem {
  final String title;
  final String? details;
  final String time;

  const _NotificationItem({
    required this.title,
    this.details,
    required this.time,
  });
}
