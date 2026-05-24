import 'package:flutter/material.dart';

class AppLayout {
  // ── Breakpoints ──────────────────────────────────────────────────────────────
  static const double mobileBreak    = 768;
  static const double smallMobile    = 480;
  static const double tabletBreak    = 1024;

  // ── Page Padding ─────────────────────────────────────────────────────────────
  static double hPad(double width) {
    if (width < smallMobile)  return 20;
    if (width < mobileBreak)  return 28;
    if (width < tabletBreak)  return 56;
    return 88;
  }

  static double vPad(double width) => width < mobileBreak ? 64 : 96;

  // ── Radius ───────────────────────────────────────────────────────────────────
  static const double radiusSm  = 8;
  static const double radiusMd  = 14;
  static const double radiusLg  = 22;
  static const double radiusXl  = 32;
  static const double radiusPill = 100;

  // ── Spacing ───────────────────────────────────────────────────────────────────
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 16;
  static const double lg  = 24;
  static const double xl  = 32;
  static const double xxl = 48;
  static const double xxxl = 80;

  // ── Nav ──────────────────────────────────────────────────────────────────────
  static const double navHeight = 56;
  static const double navTopPad = 20;

  // ── Card ──────────────────────────────────────────────────────────────────────
  static const EdgeInsets cardPadding = EdgeInsets.all(28);
}

class AppBreakpoints {
  const AppBreakpoints._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppLayout.mobileBreak;

  static bool isSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppLayout.smallMobile;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= AppLayout.mobileBreak && w < AppLayout.tabletBreak;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppLayout.tabletBreak;
}