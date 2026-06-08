import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/constants/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers with mockup defaults
  final _nameController = TextEditingController(text: 'Dhruvit');
  final _phoneController = TextEditingController(text: '9876543210');
  final _emailController = TextEditingController(text: 'dhruvitkhatrani@gmail.com');
  final _weightController = TextEditingController(text: '55');
  final _heightController = TextEditingController(text: '170');
  final _ageController = TextEditingController(text: '21');

  // Toggle states
  String _weightUnit = 'KG'; // LBS or KG
  String _heightUnit = 'CM'; // FEET or CM
  String _gender = 'Male';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    HapticFeedback.mediumImpact();
    if (_formKey.currentState!.validate()) {
      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully!'),
          backgroundColor: Color(0xFFB0C929),
        ),
      );
      Navigator.of(context).pop();
    }
  }

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
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'EDIT PROFILE',
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar selector section
              Center(
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFB300), // Yellow background
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Silhouette
                      const Icon(
                        Icons.person,
                        size: 85,
                        color: Color(0xFF5D4037), // Dark brown silhouette
                      ),
                      // Camera overlay
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Form fields
              _buildLabel('Full Name', isDark),
              TextFormField(
                controller: _nameController,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: _buildInputDecoration(
                  isDark: isDark,
                  suffixIcon: Icon(
                    Icons.check_rounded,
                    color: isDark ? Colors.white70 : Colors.black87,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              _buildLabel('Phone', isDark),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: _buildInputDecoration(isDark: isDark),
              ),
              const SizedBox(height: 20),

              _buildLabel('Email address', isDark),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: _buildInputDecoration(isDark: isDark),
              ),
              const SizedBox(height: 20),

              // Weight with LBS/KG toggle
              _buildLabel('Weight', isDark),
              _buildUnitInputField(
                controller: _weightController,
                unit1: 'LBS',
                unit2: 'KG',
                selectedUnit: _weightUnit,
                onUnitChanged: (value) {
                  setState(() {
                    _weightUnit = value;
                  });
                },
                isDark: isDark,
              ),
              const SizedBox(height: 20),

              // Height with FEET/CM toggle
              _buildLabel('Height', isDark),
              _buildUnitInputField(
                controller: _heightController,
                unit1: 'FEET',
                unit2: 'CM',
                selectedUnit: _heightUnit,
                onUnitChanged: (value) {
                  setState(() {
                    _heightUnit = value;
                  });
                },
                isDark: isDark,
              ),
              const SizedBox(height: 20),

              // Gender dropdown
              _buildLabel('Gender', isDark),
              DropdownButtonFormField<String>(
                initialValue: _gender,
                dropdownColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
                decoration: _buildInputDecoration(
                  isDark: isDark,
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 16),
                      Icon(
                        _gender == 'Male'
                            ? Icons.male_rounded
                            : _gender == 'Female'
                                ? Icons.female_rounded
                                : Icons.transgender_rounded,
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                items: ['Male', 'Female', 'Other'].map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  HapticFeedback.lightImpact();
                  if (value != null) {
                    setState(() {
                      _gender = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),

              // Age field
              _buildLabel('Age', isDark),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: isDark ? Colors.white : Colors.black87),
                decoration: _buildInputDecoration(isDark: isDark),
              ),
              const SizedBox(height: 36),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB0C929),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SAVE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white70 : AppColors.textSecondary,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required bool isDark,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      fillColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF6F6F6),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: prefixIcon,
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    );
  }

  Widget _buildUnitInputField({
    required TextEditingController controller,
    required String unit1,
    required String unit2,
    required String selectedUnit,
    required ValueChanged<String> onUnitChanged,
    required bool isDark,
  }) {
    final toggleBg = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE5E7EB);
    final toggleSelectedBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(left: 16, right: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          // Pill toggle switch
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: toggleBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                _buildToggleItem(
                  label: unit1,
                  isSelected: selectedUnit == unit1,
                  bg: toggleSelectedBg,
                  isDark: isDark,
                  onTap: () => onUnitChanged(unit1),
                ),
                _buildToggleItem(
                  label: unit2,
                  isSelected: selectedUnit == unit2,
                  bg: toggleSelectedBg,
                  isDark: isDark,
                  onTap: () => onUnitChanged(unit2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required String label,
    required bool isSelected,
    required Color bg,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? bg : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    spreadRadius: 1,
                  )
                ]
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected
                ? (isDark ? Colors.white : Colors.black87)
                : (isDark ? Colors.white38 : Colors.black38),
          ),
        ),
      ),
    );
  }
}
