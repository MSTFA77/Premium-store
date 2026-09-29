import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_container.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(color: AppColors.textPrimary),
        cursorColor: AppColors.accent,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'What do you search for?',
          hintStyle: TextStyle(color: AppColors.textSecondary),
          prefixIcon: Icon(Icons.search_rounded, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
