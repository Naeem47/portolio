import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'portfolio_data.dart';
import 'theme.dart';

class FooterSection extends StatelessWidget {
  final bool isMobile;

  const FooterSection({
    super.key,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final hPad = AppLayout.hPad(MediaQuery.of(context).size.width);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: hPad,
        vertical: isMobile ? 40 : 56,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.white.withOpacity(0.03),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        children: [
          if (!isMobile) const _Divider(),
          const SizedBox(height: 32),

          const _FooterBottom(),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.accent.withOpacity(0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  final bool isMobile;

  const _SocialLinks({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final socials = [
      ('GitHub', LucideIcons.github, 'github.com/yourusername'),
      ('LinkedIn', LucideIcons.linkedin, 'linkedin.com/in/yourusername'),
      ('Twitter', LucideIcons.twitter, 'twitter.com/yourusername'),
      ('Email', LucideIcons.mail, 'hello@yourdomain.com'),
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: isMobile ? 28 : 40,
      runSpacing: 16,
      children: socials.map((social) {
        return _SocialLink(
          icon: social.$2,
          label: social.$1,
          url: social.$3,
        );
      }).toList(),
    );
  }
}

class _SocialLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialLink({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: () {
          // Add your URL launcher logic here
          // You can use url_launcher package
        },
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTextStyles.mono(
            fontSize: 13,
            color: hovered
                ? AppColors.accent
                : AppColors.muted.withOpacity(0.6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 16,
                color: hovered
                    ? AppColors.accent
                    : AppColors.muted.withOpacity(0.5),
              ),
              const SizedBox(width: 10),
              Text(widget.label),
            ],
          ),
        ),
      ),
    );
  }
}

class _FooterBottom extends StatelessWidget {
  const _FooterBottom();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Crafted with precision • Driven by curiosity",
          textAlign: TextAlign.center,
          style: AppTextStyles.mono(
            fontSize: 11,
            color: AppColors.muted,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "© 2026 ${PortfolioData.name}",
          textAlign: TextAlign.center,
          style: AppTextStyles.mono(
            fontSize: 12,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }
}