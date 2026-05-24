import 'package:flutter/material.dart';

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