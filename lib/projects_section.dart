import 'package:flutter/material.dart';
import 'package:portfolio/animations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models.dart';
import 'portfolio_data.dart';
import 'shared_widgets.dart';
import 'theme.dart';

class ProjectsSection extends StatelessWidget {
  final bool isMobile;
  final bool isSmallMobile;

  const ProjectsSection({
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
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppLayout.xxxl),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel("Projects"),
            const SizedBox(height: 20),
            Text(
              "Things I've shipped.",
              style: AppTextStyles.sectionTitle(fontSize: isMobile ? 32 : 44),
            ),
            const SizedBox(height: AppLayout.xxl),
            ...List.generate(
              PortfolioData.projects.length,
              (i) => FadeSlideIn(
                delay: Duration(milliseconds: 100 * i),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _ProjectCard(
                    project: PortfolioData.projects[i],
                    isMobile: isMobile,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool isMobile;
  const _ProjectCard({required this.project, required this.isMobile});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        padding: AppLayout.cardPadding,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.card, Color(0xFF0E1520)],
          ),
          borderRadius: BorderRadius.circular(AppLayout.radiusLg),
          border: Border.all(
            color: _hovered ? p.color.withOpacity(0.4) : AppColors.border,
          ),
          boxShadow: _hovered
              ? [AppColors.glowShadow(p.color, opacity: 0.14, blur: 28)]
              : [],
        ),
        child: widget.isMobile ? _MobileCard(p: p) : _DesktopCard(p: p),
      ),
    );
  }
}

class _DesktopCard extends StatelessWidget {
  final Project p;
  const _DesktopCard({required this.p});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NumberBadge(number: p.number, color: p.color),
        const SizedBox(width: 32),
        Expanded(child: _ProjectBody(p: p)),
      ],
    );
  }
}

class _MobileCard extends StatelessWidget {
  final Project p;
  const _MobileCard({required this.p});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NumberBadge(number: p.number, color: p.color),
        const SizedBox(height: 16),
        _ProjectBody(p: p),
      ],
    );
  }
}

class _NumberBadge extends StatelessWidget {
  final String number;
  final Color color;
  const _NumberBadge({required this.number, required this.color});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [color.withOpacity(0.6), color.withOpacity(0.2)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds),
      child: Text(
        number,
        style: AppTextStyles.heroName(fontSize: 48),
      ),
    );
  }
}

class _ProjectBody extends StatelessWidget {
  final Project p;
  const _ProjectBody({required this.p});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                p.title,
                style: AppTextStyles.sectionTitle(fontSize: 22),
              ),
            ),
            const SizedBox(width: 12),
            _StatBadge(label: p.stat, color: p.color),
          ],
        ),
        const SizedBox(height: 12),
        Text(p.description, style: AppTextStyles.body(fontSize: 14)),
        const SizedBox(height: 20),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...p.tags.map(
              (t) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.border.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppLayout.radiusSm),
                ),
                child: Text(t, style: AppTextStyles.mono(fontSize: 11)),
              ),
            ),
            _LearnMoreBtn(
              color: p.color,
              onTap: () => launchUrl(Uri.parse(p.link)),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _StatBadge({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(AppLayout.radiusPill),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: AppTextStyles.monoBold(fontSize: 11, color: color),
      ),
    );
  }
}

class _LearnMoreBtn extends StatefulWidget {
  final Color color;
  final VoidCallback onTap;
  const _LearnMoreBtn({required this.color, required this.onTap});

  @override
  State<_LearnMoreBtn> createState() => _LearnMoreBtnState();
}

class _LearnMoreBtnState extends State<_LearnMoreBtn> {
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
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _hovered ? widget.color.withOpacity(0.12) : Colors.transparent,
            borderRadius: BorderRadius.circular(AppLayout.radiusSm),
            border: Border.all(
              color: _hovered ? widget.color : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Learn More",
                style: AppTextStyles.mono(
                  fontSize: 11,
                  color: _hovered ? widget.color : AppColors.mutedLight,
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_forward,
                size: 12,
                color: _hovered ? widget.color : AppColors.mutedLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}