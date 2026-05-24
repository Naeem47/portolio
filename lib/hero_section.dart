import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'portfolio_data.dart';
import 'shared_widgets.dart';
import 'theme.dart';

class HeroSection extends StatefulWidget {
  final bool isMobile;
  final bool isSmallMobile;
  final VoidCallback onScrollDown;

  const HeroSection({
    super.key,
    required this.isMobile,
    required this.isSmallMobile,
    required this.onScrollDown,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  double get _nameFontSize =>
      widget.isSmallMobile ? 38 : (widget.isMobile ? 50 : 72);
  double get _roleFontSize => widget.isMobile ? 18 : 24;
  double get _hPad => widget.isSmallMobile ? 20 : (widget.isMobile ? 28 : 88);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Stack(
          children: [
            // Grid background
            Positioned.fill(
              child: CustomPaint(
                painter: GridPatternPainter(
                  color: AppColors.border.withOpacity(0.4),
                  spacing: 52,
                ),
              ),
            ),
            // Radial glow behind heading
            Positioned(
              top: -80,
              left: -60,
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.06),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: _hPad,
                vertical: widget.isMobile ? 64 : 96,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Available badge
                  _AvailabilityBadge(),
                  const SizedBox(height: 32),
                  // Name with gradient mask
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppColors.white, Color(0xFFB0C8D8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      PortfolioData.name,
                      style: AppTextStyles.heroName(fontSize: _nameFontSize),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Animated role typewriter
                  _AnimatedRoleRow(isMobile: widget.isMobile, fontSize: _roleFontSize),
                  const SizedBox(height: 24),
                  // Bio
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: Text(
                      PortfolioData.bio,
                      style: AppTextStyles.body(fontSize: widget.isMobile ? 15 : 17),
                    ),
                  ),
                  const SizedBox(height: 40),
                  // CTA buttons
                  Wrap(
                    spacing: 14,
                    runSpacing: 12,
                    children: [
                      AccentButton(
                        label: "View Projects",
                        icon: FontAwesomeIcons.arrowDownShortWide,
                        onTap: widget.onScrollDown,
                      ),
                      OutlineButton(
                        label: "Download CV",
                        icon: FontAwesomeIcons.download,
                        onTap: () => launchUrl(Uri.parse(PortfolioData.linkedIn)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 64),
                  // Stats row
                  _StatsRow(isMobile: widget.isMobile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentBg,
            AppColors.accentBg.withOpacity(0.4),
          ],
        ),
        borderRadius: BorderRadius.circular(AppLayout.radiusPill),
        border: Border.all(color: AppColors.accentDeep.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PulsingDot(color: AppColors.accent, size: 7),
          const SizedBox(width: 10),
          Text(
            'Available for new opportunities',
            style: AppTextStyles.mono(fontSize: 11, color: AppColors.accent),
          ),
        ],
      ),
    );
  }
}
class _AnimatedRoleRow extends StatelessWidget {
  final bool isMobile;
  final double fontSize;

  const _AnimatedRoleRow({
    required this.isMobile,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final animatedWidth = isMobile
            ? constraints.maxWidth
            : (constraints.maxWidth * 0.62).clamp(220.0, 500.0);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "I build",
              style: AppTextStyles.body(
                fontSize: fontSize,
                color: AppColors.muted,
              ),
            ),

            const SizedBox(height: 6),

            SizedBox(
              width: animatedWidth,
              height: fontSize * 1.6,
              child: AnimatedTextKit(
                repeatForever: true,
                pause: const Duration(milliseconds: 900),
                animatedTexts: PortfolioData.animatedRoles
                    .map(
                      (r) => TypewriterAnimatedText(
                        r,
                        textStyle: AppTextStyles.monoBold(
                          fontSize: fontSize,
                          color: AppColors.accent,
                        ),
                        speed: const Duration(milliseconds: 65),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
class _StatsRow extends StatelessWidget {
  final bool isMobile;
  const _StatsRow({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      AnimatedCounter(value: 5.5, label: "Years Exp", suffix: "+"),
      AnimatedCounter(value: 500, label: "Downloads", suffix: "K+"),
      const StatChip(value: "Full-Stack", label: "Flutter · Node · NestJS"),
      if (!isMobile)
        const StatChip(value: "Mid→Senior", label: "Growth track"),
    ];

    if (isMobile) {
      return Wrap(spacing: 24, runSpacing: 20, children: items.take(3).toList());
    }
    return Row(
      children: items.expand((w) sync* {
        yield w;
        if (w != items.last) yield const VerticalSeparator();
      }).toList(),
    );
  }
}

// ── Animated counter ─────────────────────────────────────────────────────────
class AnimatedCounter extends StatefulWidget {
  final double value;
  final String label;
  final String suffix;

  const AnimatedCounter({
    super.key,
    required this.value,
    required this.label,
    this.suffix = '',
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  double _display = 0;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _anim = Tween<double>(begin: 0, end: widget.value)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _anim.addListener(() => setState(() => _display = _anim.value));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_triggered) {
          _triggered = true;
          _ctrl.forward();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_display % 1 == 0 ? _display.toInt() : _display.toStringAsFixed(1)}${widget.suffix}',
            style: AppTextStyles.statValue,
          ),
          const SizedBox(height: 3),
          Text(widget.label, style: AppTextStyles.statLabel),
        ],
      ),
    );
  }
}