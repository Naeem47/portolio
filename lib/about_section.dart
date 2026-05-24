import 'package:flutter/material.dart';
import 'package:portfolio/animations.dart';
import 'package:portfolio/portfolio_data.dart';

import 'shared_widgets.dart';
import 'theme.dart';

class AboutSection extends StatelessWidget {
  final bool isMobile;
  const AboutSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final hPad = AppLayout.hPad(MediaQuery.of(context).size.width);

    return FadeSlideIn(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppLayout.xxxl),
        decoration: BoxDecoration(
          border: const Border(top: BorderSide(color: AppColors.border)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.surface.withOpacity(0.6), Colors.transparent],
          ),
        ),
        child: isMobile ? _MobileLayout() : _DesktopLayout(),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionLabel("About"),
              const SizedBox(height: 20),
              Text(
                "The engineer\nbehind the\nproduct.",
                style: AppTextStyles.sectionTitle(fontSize: 44),
              ),
              const SizedBox(height: 32),
              // Decorative vertical accent bar
              Row(
                children: [
                  Container(
                    width: 3,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      "Building digital\nproducts since 2022",
                      style: AppTextStyles.mono(
                        fontSize: 13,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 6,
          child: _AboutContent(),
        ),
      ],
    );
  }
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel("About"),
        const SizedBox(height: 20),
        Text(
          "The engineer\nbehind the product.",
          style: AppTextStyles.sectionTitle(fontSize: 32),
        ),
        const SizedBox(height: 32),
        _AboutContent(),
      ],
    );
  }
}

class _AboutContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredList(
      baseDelay: const Duration(milliseconds: 100),
      stagger: const Duration(milliseconds: 100),
      children: [
        Text(PortfolioData.aboutPara1, style: AppTextStyles.body(fontSize: 16)),
        const SizedBox(height: 20),
        Text(PortfolioData.aboutPara2, style: AppTextStyles.body(fontSize: 16)),
        const SizedBox(height: 32),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: PortfolioData.aboutTags
              .map((t) => AccentTag(t))
              .toList(),
        ),
      ],
    );
  }
}