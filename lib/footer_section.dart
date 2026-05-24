import 'package:flutter/material.dart';

import 'portfolio_data.dart';
import 'theme.dart';

class FooterSection extends StatelessWidget {
  final bool isMobile;
  const FooterSection({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final hPad = AppLayout.hPad(MediaQuery.of(context).size.width);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: AppLayout.xl),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: isMobile ? _MobileFooter() : _DesktopFooter(),
    );
  }
}

class _DesktopFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "© 2025 ${PortfolioData.name}",
          style: AppTextStyles.mono(fontSize: 12),
        ),
        Row(
          children: [
            Icon(Icons.favorite_rounded, size: 12, color: AppColors.accent),
            const SizedBox(width: 6),
            Text("Built with Flutter", style: AppTextStyles.mono(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

class _MobileFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.favorite_rounded, size: 12, color: AppColors.accent),
            const SizedBox(width: 6),
            Text("Built with Flutter", style: AppTextStyles.mono(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "© 2025 ${PortfolioData.name}",
          style: AppTextStyles.mono(fontSize: 12),
        ),
      ],
    );
  }
}