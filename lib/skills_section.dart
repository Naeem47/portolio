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
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppLayout.xxxl),
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
            _SkillsGrid(isMobile: isMobile, isSmallMobile: isSmallMobile),
          ],
        ),
      ),
    );
  }
}

class _SkillsGrid extends StatelessWidget {
  final bool isMobile;
  final bool isSmallMobile;

  const _SkillsGrid({required this.isMobile, required this.isSmallMobile});

  @override
  Widget build(BuildContext context) {
    final cats = PortfolioData.skills;

    if (isMobile) {
      return Column(
        children: List.generate(cats.length, (i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: FadeSlideIn(
              delay: Duration(milliseconds: 80 * i),
              child: SkillCard(cat: cats[i]),
            ),
          );
        }),
      );
    }

    // Desktop: 2-column grid
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: 2.1,
      ),
      itemCount: cats.length,
      itemBuilder: (_, i) => FadeSlideIn(
        delay: Duration(milliseconds: 80 * i),
        child: SkillCard(cat: cats[i]),
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final SkillCategory cat;
  const SkillCard({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return GlowCard(
      glowColor: cat.color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              PulsingDot(color: cat.color, size: 9),
              const SizedBox(width: 10),
              Text(
                cat.title.toUpperCase(),
                style: AppTextStyles.monoBold(
                  fontSize: 11,
                  color: cat.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppLayout.lg),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: cat.skills
                .map((s) => SkillPill(s, color: cat.color))
                .toList(),
          ),
        ],
      ),
    );
  }
}