import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/theme_manager.dart';

class AppSettingScreen extends StatefulWidget {
  const AppSettingScreen({super.key});

  @override
  State<AppSettingScreen> createState() => _AppSettingScreenState();
}

class _AppSettingScreenState extends State<AppSettingScreen> {
  bool _appleHealthEnabled = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dividerColor = isDark ? Colors.white10 : const Color(0xFFEEEEEE);

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
          'APP SETTING',
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
            children: [
              const SizedBox(height: 16),
              // Reminder Setting
              _buildSettingItem(
                icon: Icons.notifications_none_outlined,
                label: 'Reminder',
                isDark: isDark,
                onTap: () {
                  _showToast(context, 'Reminder Settings');
                },
              ),
              Divider(height: 1, color: dividerColor),
              // Change Password Setting
              _buildSettingItem(
                icon: Icons.lock_outline_rounded,
                label: 'Change Password',
                isDark: isDark,
                onTap: () {
                  _showToast(context, 'Change Password');
                },
              ),
              Divider(height: 1, color: dividerColor),
              // Apple Health Toggle
              _buildSettingItem(
                icon: Icons.favorite_border_rounded,
                label: 'Apple Health',
                isDark: isDark,
                trailing: Switch(
                  value: _appleHealthEnabled,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.lime,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE5E7EB),
                  trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                  onChanged: (value) {
                    setState(() {
                      _appleHealthEnabled = value;
                    });
                  },
                ),
              ),
              Divider(height: 1, color: dividerColor),
              // Dark Mode Toggle
              _buildSettingItem(
                icon: Icons.mode_night_outlined,
                label: 'Dark Mode',
                isDark: isDark,
                trailing: Switch(
                  value: isDarkModeNotifier.value,
                  activeThumbColor: Colors.white,
                  activeTrackColor: AppColors.lime,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFE5E7EB),
                  trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
                  onChanged: (value) {
                    setState(() {
                      isDarkModeNotifier.value = value;
                    });
                  },
                ),
              ),
              Divider(height: 1, color: dividerColor),
              // Language Selection
              _buildSettingItem(
                icon: Icons.language_outlined,
                label: 'Language',
                isDark: isDark,
                trailing: const Text(
                  'English',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  _showToast(context, 'Change Language');
                },
              ),
              Divider(height: 1, color: dividerColor),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lime,
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  _showToast(context, 'Upgrading to premium...');
                },
                child: const Text(
                  'UPGRADE PREMIUM',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Version 1.0',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String label,
    required bool isDark,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 24, color: isDark ? Colors.white70 : Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
