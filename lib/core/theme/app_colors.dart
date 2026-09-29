import 'package:flutter/material.dart';

/// Two-color brand palette — Cream Vanilla + Cherry Cola — plus a small
/// set of tints/shades derived from those exact two hues for backgrounds,
/// text and borders. No unrelated colors are introduced.
class AppColors {
  const AppColors._();

  // Brand
  static const Color creamVanilla = Color(0xFFEFE6DD);
  static const Color cherryCola = Color(0xFF9A0002);

  // Background gradient — cream warming toward a soft cherry blush, so
  // the glass blur behind cards has something real to differentiate.
  static const Color gradientStart = creamVanilla;
  static const Color gradientMid = Color(0xFFE9D9CD);
  static const Color gradientEnd = Color(0xFFF0D2CE);

  // Text — strong, high-contrast warm near-black on cream.
  static const Color textPrimary = Color(0xFF2B1712);
  static const Color textSecondary = Color(0xFF8A7568);

  // Glass surfaces — opaque enough to read clearly, cherry-tinted edge.
  static const Color glassFill = Color(0xC2FBF6F0);
  static const Color glassBorder = Color(0x479A0002);

  // Actions
  static const Color accent = cherryCola;
  static const Color danger = Color(0xFF7A0001);
  static const Color star = cherryCola;
}
