import 'package:flutter/material.dart';
import 'package:portfolio/animations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'portfolio_data.dart';
import 'shared_widgets.dart';
import 'theme.dart';

class ContactSection extends StatelessWidget {
  final bool isMobile;
  const ContactSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final hPad = AppLayout.hPad(MediaQuery.of(context).size.width);

    return FadeSlideIn(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppLayout.xxxl),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.surface, AppColors.bg],
          ),
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionLabel("Contact"),
            const SizedBox(height: 20),
            Text(
              "Let's build\nsomething.",
              style: AppTextStyles.sectionTitle(fontSize: isMobile ? 40 : 60),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Text(
                "If you're building a product involving video, streaming, or complex mobile workflows — I'd enjoy the conversation.",
                style: AppTextStyles.body(fontSize: 16),
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 14,
              runSpacing: 12,
              children: PortfolioData.socials
                  .map(
                    (s) => _SocialButton(
                      label: s.label,
                      icon: s.icon,
                      onTap: () => launchUrl(Uri.parse(s.url)),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 13),
          decoration: BoxDecoration(
            gradient: _hovered
                ? LinearGradient(colors: [
                    AppColors.accent.withOpacity(0.18),
                    AppColors.accentDim.withOpacity(0.08),
                  ])
                : null,
            color: _hovered ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(AppLayout.radiusPill),
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [AppColors.glowShadow(AppColors.accent, opacity: 0.18, blur: 16)]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: _hovered ? AppColors.accent : AppColors.mutedLight,
              ),
              const SizedBox(width: 9),
              Text(
                widget.label,
                style: AppTextStyles.body(
                  fontSize: 14,
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