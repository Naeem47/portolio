import 'dart:ui';
import 'package:flutter/material.dart';

import 'portfolio_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'shared_widgets.dart';
import 'theme.dart';

// ── Floating Navigation Bar ───────────────────────────────────────────────────

class FloatingNav extends StatefulWidget {
  final bool isMobile;
  final void Function(int) onTap;

  const FloatingNav({super.key, required this.isMobile, required this.onTap});

  @override
  State<FloatingNav> createState() => _FloatingNavState();
}

class _FloatingNavState extends State<FloatingNav>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideCtrl;
  late final Animation<Offset> _slideAnim;
  late final Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, -1.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
    _fadeAnim = CurvedAnimation(parent: _slideCtrl, curve: Curves.easeIn);
    // Kick off entrance animation
    WidgetsBinding.instance.addPostFrameCallback((_) => _slideCtrl.forward());
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: AppLayout.navTopPad),
        child: SlideTransition(
          position: _slideAnim,
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppLayout.radiusPill),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    // Rich dark glass — never goes grey
                    color: const Color(0xFF0D1117).withOpacity(0.82),
                    borderRadius: BorderRadius.circular(AppLayout.radiusPill),
                    border: Border.all(
                      color: AppColors.accent.withOpacity(0.18),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.45),
                        blurRadius: 28,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.06),
                        blurRadius: 40,
                        spreadRadius: -4,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ── Logo pill ──────────────────────────────────────────
                      _LogoPill(
                        initials: PortfolioData.initials,
                        onTap: () => widget.onTap(0),
                      ),

                      if (!widget.isMobile) ...[
                        const SizedBox(width: 4),
                        // ── Nav items ──────────────────────────────────────
                        ...List.generate(
                          PortfolioData.navItems.length,
                          (i) => _NavPill(
                            label: PortfolioData.navItems[i].label,
                            onTap: () => widget.onTap(i),
                          ),
                        ),
                        const SizedBox(width: 4),
                      ] else
                        const SizedBox(width: 8),

                      // ── CTA ────────────────────────────────────────────────
                      _HireMeButton(onTap: () => widget.onTap(4)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Logo Pill ──────────────────────────────────────────────────────────────────

class _LogoPill extends StatefulWidget {
  final String initials;
  final VoidCallback onTap;
  const _LogoPill({required this.initials, required this.onTap});

  @override
  State<_LogoPill> createState() => _LogoPillState();
}

class _LogoPillState extends State<_LogoPill> {
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
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppLayout.radiusPill),
            color: _hovered
                ? AppColors.accent.withOpacity(0.18)
                : AppColors.accent.withOpacity(0.10),
            border: Border.all(
              color: AppColors.accent.withOpacity(_hovered ? 0.55 : 0.3),
              width: 1,
            ),
          ),
          child: Text(
            widget.initials,
            style: AppTextStyles.monoBold(
              fontSize: 13,
              color: AppColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Nav Pill ───────────────────────────────────────────────────────────────────

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppLayout.radiusPill),
            color: _hovered
                ? AppColors.accent.withOpacity(0.10)
                : Colors.transparent,
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: AppTextStyles.navItem(active: _hovered),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

// ── Hire Me CTA Button ─────────────────────────────────────────────────────────

class _HireMeButton extends StatefulWidget {
  final VoidCallback onTap;
  const _HireMeButton({required this.onTap});

  @override
  State<_HireMeButton> createState() => _HireMeButtonState();
}

class _HireMeButtonState extends State<_HireMeButton>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late final AnimationController _shimmerCtrl;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerCtrl.dispose();
    super.dispose();
  }

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
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppLayout.radiusPill),
            gradient: LinearGradient(
              colors: _hovered
                  ? [
                      AppColors.accent,
                      AppColors.accent.withOpacity(0.75),
                    ]
                  : [
                      AppColors.accent.withOpacity(0.9),
                      AppColors.accent.withOpacity(0.6),
                    ],
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.38),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Text(
            'Hire Me',
            style: AppTextStyles.monoBold(
              fontSize: 12,
              color: Colors.black,
            ),
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
      width: 300,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0D1117),
              Color(0xFF0A0F1A),
              Color(0xFF060B12),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // ── Decorative accent glow top-right ───────────────────────────
            Positioned(
              top: -60,
              right: -40,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withOpacity(0.12),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // ── Accent border on right edge ────────────────────────────────
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                width: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.accent.withOpacity(0.35),
                      AppColors.accent.withOpacity(0.35),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.2, 0.8, 1.0],
                  ),
                ),
              ),
            ),

            // ── Content ────────────────────────────────────────────────────
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),

                  // ── Profile Header ──────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Avatar with ring
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Glow ring
                            Container(
                              width: 76,
                              height: 76,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.accent.withOpacity(0.4),
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent.withOpacity(0.2),
                                    blurRadius: 18,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                            GlowAvatar(
                              initials: PortfolioData.initials,
                              size: 68,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        Text(
                          PortfolioData.name,
                          style: AppTextStyles.sectionTitle(fontSize: 20),
                        ),
                        const SizedBox(height: 5),
                        // Role badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.accent.withOpacity(0.12),
                            border: Border.all(
                              color: AppColors.accent.withOpacity(0.28),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            PortfolioData.role,
                            style: AppTextStyles.mono(
                              fontSize: 11,
                              color: AppColors.accent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Divider ─────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.border.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Nav Items ────────────────────────────────────────────
                  ...List.generate(
                    PortfolioData.navItems.length,
                    (i) => _DrawerItem(
                      icon: PortfolioData.navItems[i].icon,
                      label: PortfolioData.navItems[i].label,
                      index: i,
                      onTap: () {
                        Navigator.pop(context);
                        onTap(i);
                      },
                    ),
                  ),

                  const Spacer(),

                  // ── Bottom CTA + copyright ────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 0, 28, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Full-width hire me button
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            onTap(4);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
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
                                  color: AppColors.accent.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Text(
                              'Hire Me →',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.monoBold(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '© 2025 ${PortfolioData.name}',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.mono(
                            fontSize: 10,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Drawer Item ────────────────────────────────────────────────────────────────

class _DrawerItem extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final int index;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.onTap,
  });

  @override
  State<_DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<_DrawerItem> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final active = _hovered || _pressed;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTapDown:  (_) => setState(() => _pressed = true),
        onTapUp:    (_) => setState(() => _pressed = false),
        onTapCancel:  () => setState(() => _pressed = false),
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: active
                ? AppColors.accent.withOpacity(0.08)
                : Colors.transparent,
            border: Border.all(
              color: active
                  ? AppColors.accent.withOpacity(0.22)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Numbered index indicator
              SizedBox(
                width: 28,
                child: Text(
                  '0${widget.index + 1}',
                  style: AppTextStyles.mono(
                    fontSize: 10,
                    color: active
                        ? AppColors.accent
                        : AppColors.muted.withOpacity(0.5),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: active
                      ? AppColors.accent.withOpacity(0.15)
                      : AppColors.surface.withOpacity(0.5),
                  border: Border.all(
                    color: active
                        ? AppColors.accent.withOpacity(0.3)
                        : AppColors.border.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: FaIcon(
                  widget.icon,
                  size: 16,
                  color: active ? AppColors.accent : AppColors.muted,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                widget.label,
                style: AppTextStyles.body(
                  fontSize: 14,
                  color: active ? AppColors.white : AppColors.white.withOpacity(0.75),
                ),
              ),
              const Spacer(),
              AnimatedOpacity(
                opacity: active ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 10,
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