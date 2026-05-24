import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:portfolio/theme.dart';

class ParticleNetworkPainter extends CustomPainter {
  final List<Particle> particles;
  final double connectionDistance;

  ParticleNetworkPainter({
    required this.particles,
    this.connectionDistance = 150,
  }) : super(repaint: null);

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()..strokeWidth = 0.4;
    final dotPaint = Paint();

    for (int i = 0; i < particles.length; i++) {
      final a = particles[i];

      // ── Draw connections ──────────────────────────────────────────────────
      for (int j = i + 1; j < particles.length; j++) {
        final b = particles[j];
        final dx = a.x - b.x;
        final dy = a.y - b.y;
        final dist = sqrt(dx * dx + dy * dy);

        if (dist < connectionDistance) {
          final opacity = (1 - dist / connectionDistance) * 0.12;
          linePaint.color = AppColors.accent.withOpacity(opacity);
          canvas.drawLine(
            Offset(a.x * size.width, a.y * size.height),
            Offset(b.x * size.width, b.y * size.height),
            linePaint,
          );
        }
      }

      // ── Draw particle dot ─────────────────────────────────────────────────
      dotPaint.color = AppColors.accent.withOpacity(a.opacity * 0.35);
      canvas.drawCircle(
        Offset(a.x * size.width, a.y * size.height),
        a.radius,
        dotPaint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticleNetworkPainter old) => true;
}

// ── Particle model ────────────────────────────────────────────────────────────

class Particle {
  double x, y;
  double vx, vy;
  final double radius;
  double opacity;

  Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.opacity,
  });

  static Particle random(Random rng) => Particle(
        x: rng.nextDouble(),
        y: rng.nextDouble(),
        vx: (rng.nextDouble() - 0.5) * 0.00015,
        vy: (rng.nextDouble() - 0.5) * 0.00015,
        radius: rng.nextDouble() * 1.2 + 0.6,
        opacity: rng.nextDouble() * 0.5 + 0.3,
      );

  void update() {
    x += vx;
    y += vy;
    // wrap around edges
    if (x < 0) x = 1.0;
    if (x > 1) x = 0.0;
    if (y < 0) y = 1.0;
    if (y > 1) y = 0.0;
  }
}

// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:portfolio/particle_painter.dart';

class ParticleNetworkBackground extends StatefulWidget {
  const ParticleNetworkBackground({super.key});

  @override
  State<ParticleNetworkBackground> createState() =>
      _ParticleNetworkBackgroundState();
}

class _ParticleNetworkBackgroundState extends State<ParticleNetworkBackground>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  final _rng = Random();
  late final List<Particle> _particles;

  static const int _count = 55;

  @override
  void initState() {
    super.initState();
    _particles = List.generate(_count, (_) => Particle.random(_rng));
    _ticker = createTicker((_) {
      for (final p in _particles) p.update();
      setState(() {});
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: ParticleNetworkPainter(particles: _particles),
        child: const SizedBox.expand(),
      ),
    );
  }
}