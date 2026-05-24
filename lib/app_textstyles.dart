import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // ── Display ─────────────────────────────────────────────────────────────────
  static TextStyle heroName({double fontSize = 72}) => GoogleFonts.fraunces(
    color: AppColors.white,
    fontSize: fontSize,
    fontWeight: FontWeight.w800,
    height: 1.02,
    letterSpacing: -2,
  );

  static TextStyle sectionTitle({double fontSize = 44}) => GoogleFonts.fraunces(
    color: AppColors.white,
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    height: 1.12,
    letterSpacing: -0.8,
  );

  // ── Body ─────────────────────────────────────────────────────────────────────
  static TextStyle body({double fontSize = 16, Color? color}) => GoogleFonts.dmSans(
    color: color ?? AppColors.mutedLight,
    fontSize: fontSize,
    height: 1.75,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bodyBold({double fontSize = 16, Color? color}) => GoogleFonts.dmSans(
    color: color ?? AppColors.white,
    fontSize: fontSize,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  // ── Mono / Labels ────────────────────────────────────────────────────────────
  static TextStyle mono({double fontSize = 12, Color? color}) => GoogleFonts.jetBrainsMono(
    color: color ?? AppColors.mutedLight,
    fontSize: fontSize,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.4,
  );

  static TextStyle monoBold({double fontSize = 12, Color? color}) => GoogleFonts.jetBrainsMono(
    color: color ?? AppColors.accent,
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  static TextStyle sectionLabel = GoogleFonts.jetBrainsMono(
    color: AppColors.accentDeep,
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 2.5,
  );

  // ── Nav ───────────────────────────────────────────────────────────────────────
  static TextStyle navItem({bool active = false}) => GoogleFonts.dmSans(
    color: active ? AppColors.accent : AppColors.mutedLight,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static TextStyle button({double fontSize = 14, Color? color}) => GoogleFonts.dmSans(
    color: color ?? AppColors.bg,
    fontSize: fontSize,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.2,
  );

  // ── Stat ──────────────────────────────────────────────────────────────────────
  static TextStyle statValue = GoogleFonts.fraunces(
    color: AppColors.white,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
  );

  static TextStyle statLabel = GoogleFonts.dmSans(
    color: AppColors.muted,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}