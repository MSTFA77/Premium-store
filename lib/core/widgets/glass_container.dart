import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Reusable frosted-glass surface: a blurred, semi-transparent container
/// with a soft brand-colored border and a lifted shadow for depth. Used
/// for cards, the search bar, the bottom nav bar, and summary panels.
class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 22,
    this.blur = 16,
    this.padding,
    this.margin,
    this.color,
    this.borderColor,
    this.width,
    this.height,
  });

  final Widget child;
  final double borderRadius;
  final double blur;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? borderColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.cherryCola.withAlpha(10),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? AppColors.glassFill,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(color: borderColor ?? AppColors.glassBorder, width: 1.2),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
