import 'package:flutter/material.dart';
import 'package:portfolio/about_section.dart';
import 'package:portfolio/contact_section.dart';
import 'package:portfolio/footer_section.dart';
import 'package:portfolio/hero_section.dart';
import 'package:portfolio/projects_section.dart';
import 'package:portfolio/skills_section.dart';

import 'nav_widgets.dart';
import 'theme.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scroll = ScrollController();

  // Section keys for scroll-to
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  bool _navVisible = false;
  bool _showBackToTop = false;

  List<GlobalKey> get _sectionKeys => [
    _heroKey,
    _aboutKey,
    _skillsKey,
    _projectsKey,
    _contactKey,
  ];

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scroll.offset;
    final showNav = offset > 80;
    final showTop = offset > 300;
    if (showNav != _navVisible || showTop != _showBackToTop) {
      setState(() {
        _navVisible = showNav;
        _showBackToTop = showTop;
      });
    }
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _scrollToTop() => _scroll.animateTo(
    0,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < AppLayout.mobileBreak;
    final isSmallMob = width < AppLayout.smallMobile;

    return Scaffold(
      backgroundColor: AppColors.bg,
      drawer: isMobile
          ? MobileDrawer(
              onTap: (i) {
                Navigator.pop(context);
                _scrollTo(_sectionKeys[i]);
              },
            )
          : null,
      body: Stack(
        children: [
          // ── Main scroll content ──────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(gradient: AppColors.bgGradient),
            child: SingleChildScrollView(
              controller: _scroll,
              child: Column(
                children: [
                  HeroSection(
                    key: _heroKey,
                    isMobile: isMobile,
                    isSmallMobile: isSmallMob,
                    onScrollDown: () => _scrollTo(_aboutKey),
                  ),
                  AboutSection(key: _aboutKey, isMobile: isMobile),
                  SkillsSection(
                    key: _skillsKey,
                    isMobile: isMobile,
                    isSmallMobile: isSmallMob,
                  ),
                  ProjectsSection(
                    key: _projectsKey,
                    isMobile: isMobile,
                    isSmallMobile: isSmallMob,
                  ),
                  ContactSection(key: _contactKey, isMobile: isMobile),
                  FooterSection(isMobile: isMobile),
                ],
              ),
            ),
          ),

          // // ── Floating nav bar ─────────────────────────────────────────────────
          if (!isMobile)
            AnimatedOpacity(
              opacity: _navVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: IgnorePointer(
                ignoring: !_navVisible,
                child: FloatingNav(
                  isMobile: isMobile,
                  onTap: (i) => _scrollTo(_sectionKeys[i]),
                ),
              ),
            ),

          // // ── Back to top FAB ──────────────────────────────────────────────────
          if (isMobile)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: AnimatedOpacity(
                  opacity: _showBackToTop ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  
                  child: IgnorePointer(
                    ignoring: !_showBackToTop,
                    child: _BackToTopButton(onTap: _scrollToTop),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BackToTopButton extends StatefulWidget {
  final VoidCallback onTap;
  const _BackToTopButton({required this.onTap});

  @override
  State<_BackToTopButton> createState() => _BackToTopButtonState();
}

class _BackToTopButtonState extends State<_BackToTopButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            gradient: AppColors.accentGradient,
            shape: BoxShape.circle,
            boxShadow: [
              AppColors.glowShadow(
                AppColors.accent,
                opacity: _hovered ? 0.55 : 0.3,
                blur: _hovered ? 20 : 12,
              ),
            ],
          ),
          child: const Icon(
            Icons.keyboard_arrow_up_rounded,
            color: AppColors.bg,
            size: 22,
          ),
        ),
      ),
    );
  }
}
