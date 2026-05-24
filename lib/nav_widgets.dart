import 'dart:ui';
import 'package:flutter/material.dart';

import 'portfolio_data.dart';
import 'shared_widgets.dart';
import 'theme.dart';

class FloatingNav extends StatelessWidget {
  final bool isMobile;
  final void Function(int) onTap;

  const FloatingNav({super.key, required this.isMobile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: AppLayout.navTopPad),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppLayout.radiusPill),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              decoration: BoxDecoration(
                color: AppColors.surface.withOpacity(0.88),
                borderRadius: BorderRadius.circular(AppLayout.radiusPill),
                border: Border.all(color: AppColors.border.withOpacity(0.6)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.bg.withOpacity(0.6),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  GestureDetector(
                    onTap: () => onTap(0),
                    child: Text(
                      PortfolioData.initials,
                      style: AppTextStyles.monoBold(
                        fontSize: 14,
                        color: AppColors.accent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  if (!isMobile) ...[
                    ...List.generate(
                      PortfolioData.navItems.length,
                      (i) => _NavPill(
                        label: PortfolioData.navItems[i].label,
                        onTap: () => onTap(i),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  AccentButton(
                    label: "Hire Me",
                    small: true,
                    onTap: () => onTap(4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavPill extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavPill({required this.label, required this.onTap});

  @override
  State<_NavPill> createState() => _NavPillState();
}

class _NavPillState extends State<_NavPill> {
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
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppLayout.radiusPill),
            color: _hovered ? AppColors.accent.withOpacity(0.12) : Colors.transparent,
          ),
          child: Text(
            widget.label,
            style: AppTextStyles.navItem(active: _hovered),
          ),
        ),
      ),
    );
  }
}

// ── Mobile Drawer ─────────────────────────────────────────────────────────────
class MobileDrawer extends StatelessWidget {
  final void Function(int) onTap;
  const MobileDrawer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.card, Color(0xFF0E1520)],
          ),
          border: Border(right: BorderSide(color: AppColors.border)),
        ),
        child: Column(
          children: [
            const SizedBox(height: 64),
            // Profile section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  GlowAvatar(initials: PortfolioData.initials, size: 76),
                  const SizedBox(height: 16),
                  Text(
                    PortfolioData.name,
                    style: AppTextStyles.sectionTitle(fontSize: 20),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    PortfolioData.role,
                    style: AppTextStyles.mono(
                      fontSize: 12,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Divider(color: AppColors.border, thickness: 1, indent: 24, endIndent: 24),
            const SizedBox(height: 16),
            ...List.generate(
              PortfolioData.navItems.length,
              (i) => ListTile(
                leading: Icon(
                  PortfolioData.navItems[i].icon,
                  color: AppColors.accent,
                  size: 20,
                ),
                title: Text(
                  PortfolioData.navItems[i].label,
                  style: AppTextStyles.body(
                    fontSize: 15,
                    color: AppColors.white,
                  ),
                ),
                onTap: () => onTap(i),
                hoverColor: AppColors.accent.withOpacity(0.08),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                '© 2025 ${PortfolioData.name}',
                style: AppTextStyles.mono(fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}