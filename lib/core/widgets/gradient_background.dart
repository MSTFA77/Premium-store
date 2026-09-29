import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Warm cream-to-blush backdrop with soft ambient cherry-cola color blobs,
/// giving the glass surfaces on top something to meaningfully blur against.
class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.gradientStart, AppColors.gradientMid, AppColors.gradientEnd],
            ),
          ),
        ),
        const Positioned(
          top: -80,
          right: -60,
          child: _Blob(size: 260, opacity: 0.16),
        ),
        const  Positioned(
          bottom: -100,
          left: -80,
          child: _Blob(size: 320, opacity: 0.10),
        ),
        child,
      ],
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.cherryCola.withAlpha(0),
              AppColors.cherryCola.withAlpha(0),
            ],
          ),
        ),
      ),
    );
  }
}
