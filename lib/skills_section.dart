import 'package:flutter/material.dart';
import 'package:portfolio/shared_widgets.dart';

import 'animations.dart';
import 'models.dart';
import 'portfolio_data.dart';
import 'theme.dart';

class SkillsSection extends StatelessWidget {
  final bool isMobile;
  final bool isSmallMobile;

  const SkillsSection({
    super.key,
    required this.isMobile,
    required this.isSmallMobile,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = AppLayout.hPad(MediaQuery.of(context).size.width);

    return FadeSlideIn(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: hPad,
          vertical: AppLayout.xxxl,
        ),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel("Skills"),
            const SizedBox(height: 20),
            Text(
              "What I work with.",
              style: AppTextStyles.sectionTitle(
                fontSize: isMobile ? 32 : 44,
              ),
            ),
            const SizedBox(height: AppLayout.xxl),
            _SkillsGrid(
              isMobile: isMobile,
              isSmallMobile: isSmallMobile,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Grid layout ───────────────────────────────────────────────────────────────

class _SkillsGrid extends StatelessWidget {
  final bool isMobile;
  final bool isSmallMobile;

  const _SkillsGrid({required this.isMobile, required this.isSmallMobile});

  @override
  Widget build(BuildContext context) {
    final cats = PortfolioData.skills;

    if (isMobile) {
      // Single column, cards size to content — no fixed aspect ratio
      return Column(
        children: List.generate(cats.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _AnimatedSkillCard(
              cat: cats[i],
              index: i,
              isMobile: true,
            ),
          );
        }),
      );
    }

    // Desktop: 2-column, cards size to content via IntrinsicHeight rows
    final rows = <Widget>[];
    for (int i = 0; i < cats.length; i += 2) {
      final hasRight = i + 1 < cats.length;
      rows.add(
        Padding(
          padding: EdgeInsets.only(bottom: i + 2 < cats.length ? 18 : 0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: _AnimatedSkillCard(
                    cat: cats[i],
                    index: i,
                    isMobile: false,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: hasRight
                      ? _AnimatedSkillCard(
                          cat: cats[i + 1],
                          index: i + 1,
                          isMobile: false,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

// ── Animated wrapper — staggered slide-up + fade ──────────────────────────────

class _AnimatedSkillCard extends StatefulWidget {
  final SkillCategory cat;
  final int index;
  final bool isMobile;

  const _AnimatedSkillCard({
    required this.cat,
    required this.index,
    required this.isMobile,
  });

  @override
  State<_AnimatedSkillCard> createState() => _AnimatedSkillCardState();
}

class _AnimatedSkillCardState extends State<_AnimatedSkillCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    // Staggered delay per card
    Future.delayed(
      Duration(milliseconds: 120 + widget.index * 90),
      () { if (mounted) _ctrl.forward(); },
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: SkillCard(cat: widget.cat, isMobile: widget.isMobile),
      ),
    );
  }
}

// ── Skill card ────────────────────────────────────────────────────────────────

class SkillCard extends StatefulWidget {
  final SkillCategory cat;
  final bool isMobile;
  const SkillCard({super.key, required this.cat, this.isMobile = false});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        // ── Key fix: padding tight on desktop, comfortable on mobile ──
        padding: EdgeInsets.all(widget.isMobile ? 16 : 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.card,
          border: Border.all(
            color: _hovered
                ? widget.cat.color.withOpacity(0.38)
                : AppColors.border,
            width: 1,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.cat.color.withOpacity(0.12),
                    blurRadius: 28,
                    spreadRadius: -4,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 12,
                    offset: const Offset(0, 3),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // ← shrink to content, kills extra padding
          children: [
            // ── Header ───────────────────────────────────────────────
            Row(
              children: [
                _PulsingDot(color: widget.cat.color),
                const SizedBox(width: 10),
                Text(
                  widget.cat.title.toUpperCase(),
                  style: AppTextStyles.monoBold(
                    fontSize: 11,
                    color: widget.cat.color,
                  ),
                ),
                const Spacer(),
                // Chip count badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: widget.cat.color.withOpacity(0.10),
                    border: Border.all(
                      color: widget.cat.color.withOpacity(0.22),
                    ),
                  ),
                  child: Text(
                    '${widget.cat.skills.length}',
                    style: AppTextStyles.mono(
                      fontSize: 10,
                      color: widget.cat.color,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // ── Chips ─────────────────────────────────────────────────
            // Wrap with tight spacing — no extra runSpacing on mobile
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: widget.cat.skills
                  .map((s) => _SkillChip(
                        label: s,
                        color: widget.cat.color,
                        bgColor: widget.cat.bgColor,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Chip ──────────────────────────────────────────────────────────────────────

class _SkillChip extends StatefulWidget {
  final String label;
  final Color color;
  final Color bgColor;
  const _SkillChip({
    required this.label,
    required this.color,
    required this.bgColor,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.basic,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: _hovered
              ? widget.color.withOpacity(0.18)
              : widget.bgColor,
          border: Border.all(
            color: _hovered
                ? widget.color.withOpacity(0.55)
                : widget.color.withOpacity(0.20),
            width: 1,
          ),
        ),
        child: Text(
          widget.label,
          style: AppTextStyles.mono(
            fontSize: 11,
            color: _hovered ? widget.color : widget.color.withOpacity(0.75),
          ),
        ),
      ),
    );
  }
}

// ── Pulsing dot (self-contained, no dependency on shared_widgets) ─────────────

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
    _scale = Tween<double>(begin: 1.0, end: 2.4)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _fade  = Tween<double>(begin: 0.6, end: 0.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 14,
      height: 14,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) => Transform.scale(
              scale: _scale.value,
              child: Opacity(
                opacity: _fade.value,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}