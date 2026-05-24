import 'package:flutter/material.dart';
import 'package:portfolio/animations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'portfolio_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' ;

import 'shared_widgets.dart';
import 'theme.dart';

class ContactSection extends StatelessWidget {
  final bool isMobile;
  const ContactSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final w     = MediaQuery.of(context).size.width;
    final hPad  = AppLayout.hPad(w);

    return FadeSlideIn(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: hPad,
          vertical: AppLayout.xxxl,
        ),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.surface, AppColors.bg],
          ),
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: isMobile
            ? _MobileLayout(isMobile: isMobile)
            : _DesktopLayout(isMobile: isMobile),
      ),
    );
  }
}

// ── Desktop: two-column split ──────────────────────────────────────────────────

class _DesktopLayout extends StatelessWidget {
  final bool isMobile;
  const _DesktopLayout({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column — headline + subtext
        Expanded(
          flex: 5,
          child: _LeftContent(isMobile: isMobile),
        ),
        const SizedBox(width: 80),
        // Right column — availability card + social links
        Expanded(
          flex: 4,
          child: _RightContent(),
        ),
      ],
    );
  }
}

// ── Mobile: single column ──────────────────────────────────────────────────────

class _MobileLayout extends StatelessWidget {
  final bool isMobile;
  const _MobileLayout({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _LeftContent(isMobile: isMobile),
        const SizedBox(height: 48),
        _RightContent(),
      ],
    );
  }
}

// ── Left: headline + copy ──────────────────────────────────────────────────────

class _LeftContent extends StatelessWidget {
  final bool isMobile;
  const _LeftContent({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel("Contact"),
        const SizedBox(height: 20),
        Text(
          "Let's build\nsomething.",
          style: AppTextStyles.sectionTitle(fontSize: isMobile ? 40 : 58),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Text(
            "Whether it's a social platform, an AI-powered mobile experience, "
            "or a desktop tool that needs to just work — I'm open to hearing "
            "about interesting problems.",
            style: AppTextStyles.body(fontSize: 16),
          ),
        ),
        const SizedBox(height: 32),

        // ── What I'm great at bullets ──────────────────────────────────
        ..._bullets.map(
          (b) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    b,
                    style: AppTextStyles.body(fontSize: 14, color: AppColors.mutedLight),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  static const List<String> _bullets = [
    "Real-time & social features — chat, feeds, stories, live streaming",
    "AI integrations — camera effects, generative content, recommendations",
    "Cross-platform Flutter — mobile, web, and desktop from one codebase",
    "Full-stack ownership — NestJS APIs, PostgreSQL, WebSockets",
  ];
}

// ── Right: availability card + socials ────────────────────────────────────────

class _RightContent extends StatelessWidget {
  const _RightContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Availability card
        _AvailabilityCard(),
        const SizedBox(height: 28),

        // Social buttons
        ...PortfolioData.socials.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SocialRow(
              label: s.label,
              icon: s.icon,
              url: s.url,
              onTap: () => launchUrl(Uri.parse(s.url)),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Availability card ──────────────────────────────────────────────────────────

class _AvailabilityCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.card,
        border: Border.all(color: AppColors.accent.withOpacity(0.22)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withOpacity(0.07),
            blurRadius: 32,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status dot + label
          Row(
            children: [
              _PulseDot(),
              const SizedBox(width: 10),
              Text(
                "Available for work",
                style: AppTextStyles.monoBold(
                  fontSize: 12,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Open to full-time roles, contract work, and interesting freelance projects.",
            style: AppTextStyles.body(fontSize: 14, color: AppColors.mutedLight),
          ),
          const SizedBox(height: 20),
          // Quick-contact CTA
          GestureDetector(
            onTap: () => launchUrl(Uri.parse(PortfolioData.email)),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 13),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent,
                    AppColors.accent.withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withOpacity(0.28),
                    blurRadius: 18,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                "Send an Email  →",
                textAlign: TextAlign.center,
                style: AppTextStyles.monoBold(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Pulsing online dot ─────────────────────────────────────────────────────────

class _PulseDot extends StatefulWidget {
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: false);
    _scale = Tween<double>(begin: 1.0, end: 2.2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _fade = Tween<double>(begin: 0.7, end: 0.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Pulse ring
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
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          // Solid dot
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Social row button ──────────────────────────────────────────────────────────

class _SocialRow extends StatefulWidget {
  final String label;
  final String url;
  final FaIconData icon;
  final VoidCallback onTap;
  const _SocialRow({
    required this.label,
    required this.url,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_SocialRow> createState() => _SocialRowState();
}

class _SocialRowState extends State<_SocialRow> {
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
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: _hovered
                ? AppColors.accent.withOpacity(0.07)
                : AppColors.card.withOpacity(0.5),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withOpacity(0.35)
                  : AppColors.border,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _hovered
                      ? AppColors.accent.withOpacity(0.15)
                      : AppColors.surface,
                  border: Border.all(
                    color: _hovered
                        ? AppColors.accent.withOpacity(0.3)
                        : AppColors.border,
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    widget.icon,
                    size: 17,
                    color: _hovered ? AppColors.accent : AppColors.mutedLight,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: AppTextStyles.body(
                        fontSize: 14,
                        color: _hovered ? AppColors.white : AppColors.mutedLight,
                      ),
                    ),
                    Text(
                      widget.url
                          .replaceFirst('mailto:', '')
                          .replaceFirst('https://', ''),
                      style: AppTextStyles.mono(
                        fontSize: 10,
                        color: _hovered
                            ? AppColors.accent.withOpacity(0.7)
                            : AppColors.muted,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: _hovered ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.arrow_outward_rounded,
                  size: 14,
                  color: AppColors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}