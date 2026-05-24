import 'package:flutter/material.dart';

import 'theme.dart';

// ── Section Label ─────────────────────────────────────────────────────────────
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 2,
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 14),
        Text(text.toUpperCase(), style: AppTextStyles.sectionLabel),
      ],
    );
  }
}

// ── Accent Button ─────────────────────────────────────────────────────────────
class AccentButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool small;
  final IconData? icon;

  const AccentButton({
    super.key,
    required this.label,
    required this.onTap,
    this.small = false,
    this.icon,
  });

  @override
  State<AccentButton> createState() => _AccentButtonState();
}

class _AccentButtonState extends State<AccentButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? 18 : 28,
            vertical: widget.small ? 10 : 14,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _hovered
                  ? [AppColors.accentDim, AppColors.accent]
                  : [AppColors.accent, AppColors.accentDim],
            ),
            borderRadius: BorderRadius.circular(AppLayout.radiusMd),
            boxShadow: _hovered
                ? [AppColors.glowShadow(AppColors.accent, opacity: 0.45, blur: 20)]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: widget.small ? 14 : 18, color: AppColors.bg),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: AppTextStyles.button(fontSize: widget.small ? 13 : 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Outline Button ────────────────────────────────────────────────────────────
class OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;

  const OutlineButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  State<OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered ? AppColors.border : Colors.transparent,
            borderRadius: BorderRadius.circular(AppLayout.radiusMd),
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 18, color: _hovered ? AppColors.white : AppColors.mutedLight),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: AppTextStyles.button(
                  fontSize: 15,
                  color: _hovered ? AppColors.white : AppColors.mutedLight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Accent Tag ─────────────────────────────────────────────────────────────────
class AccentTag extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? bgColor;

  const AccentTag(this.text, {super.key, this.color, this.bgColor});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.accent;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: (bgColor ?? AppColors.accentBg).withOpacity(0.6),
        borderRadius: BorderRadius.circular(AppLayout.radiusPill),
        border: Border.all(color: c.withOpacity(0.25)),
      ),
      child: Text(
        text,
        style: AppTextStyles.mono(fontSize: 12, color: c.withOpacity(0.9)),
      ),
    );
  }
}

// ── Skill Pill ────────────────────────────────────────────────────────────────
class SkillPill extends StatelessWidget {
  final String text;
  final Color color;

  const SkillPill(this.text, {super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.12), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(AppLayout.radiusSm),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Text(
        text,
        style: AppTextStyles.mono(fontSize: 12, color: color.withOpacity(0.9)),
      ),
    );
  }
}

// ── Stat chip ─────────────────────────────────────────────────────────────────
class StatChip extends StatelessWidget {
  final String value;
  final String label;
  const StatChip({super.key, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value, style: AppTextStyles.statValue),
        const SizedBox(height: 3),
        Text(label, style: AppTextStyles.statLabel),
      ],
    );
  }
}

// ── Vertical divider ──────────────────────────────────────────────────────────
class VerticalSeparator extends StatelessWidget {
  const VerticalSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.border,
      margin: const EdgeInsets.symmetric(horizontal: 28),
    );
  }
}

// ── Glow card ────────────────────────────────────────────────────────────────
class GlowCard extends StatefulWidget {
  final Widget child;
  final Color? glowColor;
  final EdgeInsets? padding;
  final double borderRadius;
  final bool hoverEffect;

  const GlowCard({
    super.key,
    required this.child,
    this.glowColor,
    this.padding,
    this.borderRadius = AppLayout.radiusLg,
    this.hoverEffect = true,
  });

  @override
  State<GlowCard> createState() => _GlowCardState();
}

class _GlowCardState extends State<GlowCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final glow = widget.glowColor ?? AppColors.accent;
    return MouseRegion(
      onEnter: (_) => widget.hoverEffect ? setState(() => _hovered = true) : null,
      onExit:  (_) => widget.hoverEffect ? setState(() => _hovered = false) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        padding: widget.padding ?? AppLayout.cardPadding,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.card, Color(0xFF0E1520)],
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: _hovered ? glow.withOpacity(0.35) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [AppColors.glowShadow(glow, opacity: 0.12, blur: 24)]
              : [],
        ),
        child: widget.child,
      ),
    );
  }
}

// ── Avatar with glow ─────────────────────────────────────────────────────────
class GlowAvatar extends StatelessWidget {
  final String initials;
  final double size;

  const GlowAvatar({super.key, required this.initials, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.accentGradient,
        shape: BoxShape.circle,
        boxShadow: [AppColors.glowShadow(AppColors.accent, opacity: 0.4, blur: 24)],
      ),
      child: Center(
        child: Text(
          initials,
          style: AppTextStyles.bodyBold(
            fontSize: size * 0.34,
            color: AppColors.bg,
          ),
        ),
      ),
    );
  }
}

// ── Noise overlay painter ────────────────────────────────────────────────────
class GridPatternPainter extends CustomPainter {
  final Color color;
  final double spacing;

  const GridPatternPainter({
    this.color = const Color(0xFF1C2836),
    this.spacing = 48,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0.5;

    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}