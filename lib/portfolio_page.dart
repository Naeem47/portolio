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

  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  final _navVisible = ValueNotifier<bool>(false);
  final _showBackToTop = ValueNotifier<bool>(false);

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
    _navVisible.dispose();
    _showBackToTop.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scroll.offset;
    final wantNav = offset > 80;
    final wantTop = offset > 300;
    if (_navVisible.value != wantNav) _navVisible.value = wantNav;
    if (_showBackToTop.value != wantTop) _showBackToTop.value = wantTop;
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
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
    final width = MediaQuery.sizeOf(
      context,
    ).width; // sizeOf — no rebuild on padding/inset changes
    final isMobile = width < AppLayout.mobileBreak;
    final isSmallMob = width < AppLayout.smallMobile;

    return Scaffold(
      backgroundColor: AppColors.bg,

      body: Stack(
        children: [
          // ── Scrollable content — RepaintBoundary keeps it isolated ─────────
      RepaintBoundary(
  child: Container(
    decoration: const BoxDecoration(gradient: AppColors.bgGradient),
    child: CustomScrollView(
      controller: _scroll,
      physics: const ClampingScrollPhysics(),
      // slivers: [
      //   SliverToBoxAdapter(
      //     key: _heroKey,
      //     child: HeroSection(
      //       isMobile: isMobile,
      //       isSmallMobile: isSmallMob,
      //       onScrollDown: () => _scrollTo(_aboutKey),
      //     ),
      //   ),
      //   SliverToBoxAdapter(
      //     key: _aboutKey,
      //     child: AboutSection(isMobile: isMobile),
      //   ),
      //   SliverToBoxAdapter(
      //     key: _skillsKey,
      //     child: SkillsSection(
      //       isMobile: isMobile,
      //       isSmallMobile: isSmallMob,
      //     ),
      //   ),
      //   SliverToBoxAdapter(
      //     key: _projectsKey,
      //     child: RepaintBoundary(
      //       child: ProjectsSection(
      //         isMobile: isMobile,
      //         isSmallMobile: isSmallMob,
      //       ),
      //     ),
      //   ),
      //   SliverToBoxAdapter(
      //     key: _skillsKey,
      //     child: RepaintBoundary(
      //       child: SkillsSection(
      //         isMobile: isMobile,
      //         isSmallMobile: isSmallMob,
      //       ),
      //     ),
      //   ),
      //   SliverToBoxAdapter(
      //     key: _contactKey,
      //     child: ContactSection(isMobile: isMobile),
      //   ),
      //   SliverToBoxAdapter(
      //     child: FooterSection(isMobile: isMobile),
      //   ),
      // ],
  
  slivers: [
  SliverToBoxAdapter(
    key: _heroKey,
    child: HeroSection(
      isMobile: isMobile,
      isSmallMobile: isSmallMob,
      onScrollDown: () => _scrollTo(_aboutKey),
    ),
  ),
  SliverToBoxAdapter(
    key: _aboutKey,
    child: AboutSection(isMobile: isMobile),
  ),
  SliverToBoxAdapter(
    key: _skillsKey,
    child: RepaintBoundary(
      child: SkillsSection(
        isMobile: isMobile,
        isSmallMobile: isSmallMob,
      ),
    ),
  ),
  SliverToBoxAdapter(
    key: _projectsKey,
    child: RepaintBoundary(
      child: ProjectsSection(
        isMobile: isMobile,
        isSmallMobile: isSmallMob,
      ),
    ),
  ),
  SliverToBoxAdapter(
    key: _contactKey,
    child: ContactSection(isMobile: isMobile),
  ),
  SliverToBoxAdapter(
    child: FooterSection(isMobile: isMobile),
  ),
],
    ),
  ),
), // ── Floating nav — only repaints itself via ValueListenableBuilder ──
          if (!isMobile)
            _FadeOverlay(
              visible: _navVisible,
              child: FloatingNav(
                isMobile: isMobile,
                onTap: (i) => _scrollTo(_sectionKeys[i]),
              ),
            ),

          // ── Back to top FAB — same isolated repaint ───────────────────────
          if (isMobile)
            Positioned(
              right: 15,
              bottom: 15,
              child: _FadeOverlay(
                visible: _showBackToTop,
                child: _BackToTopButton(onTap: _scrollToTop),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Isolated fade overlay ─────────────────────────────────────────────────────
// Listens to a ValueNotifier and fades in/out without touching the parent tree.

class _FadeOverlay extends StatelessWidget {
  final ValueNotifier<bool> visible;
  final Widget child;

  const _FadeOverlay({required this.visible, required this.child});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: visible,
      builder: (_, show, __) => AnimatedOpacity(
        opacity: show ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
        child: IgnorePointer(ignoring: !show, child: child),
      ),
    );
  }
}

// ── Back to top button ────────────────────────────────────────────────────────

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
