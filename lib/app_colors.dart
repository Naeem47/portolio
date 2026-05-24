import 'package:flutter/material.dart';

class AppColors {
  // ── Core Palette ────────────────────────────────────────────────────────────
  static const bg         = Color(0xFF060910);
  static const surface    = Color(0xFF0C1118);
  static const card       = Color(0xFF111820);
  static const cardHover  = Color(0xFF161F29);
  static const border     = Color(0xFF1C2836);
  static const borderHover= Color(0xFF2A3A4A);

  // ── Accent: Electric Teal ───────────────────────────────────────────────────
  static const accent     = Color(0xFF00FFB2);
  static const accentDim  = Color(0xFF00C885);
  static const accentDeep = Color(0xFF008F5E);
  static const accentBg   = Color(0xFF001E17);

  // ── Secondary accents ───────────────────────────────────────────────────────
  static const purple     = Color(0xFF8B6FFF);
  static const purpleDim  = Color(0xFF6B50CC);
  static const purpleBg   = Color(0xFF130F2A);

  static const orange     = Color(0xFFFF7A45);
  static const orangeDim  = Color(0xFFCC5E2E);
  static const orangeBg   = Color(0xFF1F0E06);

  // ── Text ────────────────────────────────────────────────────────────────────
  static const white      = Color(0xFFF2F6FA);
  static const muted      = Color(0xFF5A6A7D);
  static const mutedLight = Color(0xFF8A9BAE);

  // ── Gradients ───────────────────────────────────────────────────────────────
  static const bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [bg, Color(0xFF08101A), surface],
  );

  static const cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [card, Color(0xFF0E1520)],
  );

  static const accentGradient = LinearGradient(
    colors: [accent, accentDim],
  );

  static const accentGradientReversed = LinearGradient(
    colors: [accentDim, accent],
  );

  /// Returns a subtle glow color for a given accent
  static BoxShadow glowShadow(Color color, {double opacity = 0.3, double blur = 16}) {
    return BoxShadow(
      color: color.withOpacity(opacity),
      blurRadius: blur,
      spreadRadius: 1,
    );
  }
}