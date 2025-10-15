import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedBackgroundWidget extends StatefulWidget {
  final Widget child;
  final bool isDark;

  const AnimatedBackgroundWidget({
    Key? key,
    required this.child,
    required this.isDark,
  }) : super(key: key);

  @override
  State<AnimatedBackgroundWidget> createState() =>
      _AnimatedBackgroundWidgetState();
}

class _AnimatedBackgroundWidgetState extends State<AnimatedBackgroundWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _particleController;
  final List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();

    // Animation للتدرج المتحرك
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // Animation للجزيئات
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // إنشاء الجزيئات
    _generateParticles();
  }

  void _generateParticles() {
    for (int i = 0; i < 50; i++) {
      _particles.add(Particle());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الخلفية المتدرجة المتحركة
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: widget.isDark
                      ? [
                          const Color(0xFF1a1a2e),
                          const Color(0xFF16213e),
                          const Color(0xFF0f3460),
                        ]
                      : [
                          Color.lerp(
                            const Color(0xFF667eea),
                            const Color(0xFF764ba2),
                            _controller.value,
                          )!,
                          Color.lerp(
                            const Color(0xFF764ba2),
                            const Color(0xFFf093fb),
                            _controller.value,
                          )!,
                          Color.lerp(
                            const Color(0xFFf093fb),
                            const Color(0xFF667eea),
                            _controller.value,
                          )!,
                        ],
                  stops: [
                    0.0 + (_controller.value * 0.2),
                    0.5 + (_controller.value * 0.2),
                    1.0,
                  ],
                ),
              ),
            );
          },
        ),

        // الجزيئات المتحركة
        AnimatedBuilder(
          animation: _particleController,
          builder: (context, child) {
            return CustomPaint(
              painter: ParticlesPainter(
                particles: _particles,
                animation: _particleController.value,
                isDark: widget.isDark,
              ),
              size: Size.infinite,
            );
          },
        ),

        // الأشكال الهندسية العائمة
        ..._buildFloatingShapes(),

        // المحتوى
        widget.child,
      ],
    );
  }

  List<Widget> _buildFloatingShapes() {
    return [
      _buildFloatingShape(
        top: 50,
        left: 30,
        size: 80,
        duration: 15,
        shape: BoxShape.circle,
      ),
      _buildFloatingShape(
        top: 200,
        right: 50,
        size: 120,
        duration: 20,
        shape: BoxShape.rectangle,
      ),
      _buildFloatingShape(
        bottom: 150,
        left: 80,
        size: 60,
        duration: 12,
        shape: BoxShape.circle,
      ),
      _buildFloatingShape(
        bottom: 100,
        right: 100,
        size: 90,
        duration: 18,
        shape: BoxShape.rectangle,
      ),
    ];
  }

  Widget _buildFloatingShape({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required int duration,
    required BoxShape shape,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(seconds: duration),
        // repeat: true,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(
              math.sin(value * 2 * math.pi) * 20,
              math.cos(value * 2 * math.pi) * 20,
            ),
            child: Transform.rotate(
              angle: value * 2 * math.pi,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: shape,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                  borderRadius: shape == BoxShape.rectangle
                      ? BorderRadius.circular(20)
                      : null,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// نموذج الجزيء
class Particle {
  late double x;
  late double y;
  late double size;
  late double speedX;
  late double speedY;
  late double opacity;

  Particle() {
    final random = math.Random();
    x = random.nextDouble();
    y = random.nextDouble();
    size = random.nextDouble() * 4 + 2;
    speedX = (random.nextDouble() - 0.5) * 0.002;
    speedY = (random.nextDouble() - 0.5) * 0.002;
    opacity = random.nextDouble() * 0.5 + 0.2;
  }

  void update() {
    x += speedX;
    y += speedY;

    // إعادة الجزيء من الجانب الآخر
    if (x < 0) x = 1;
    if (x > 1) x = 0;
    if (y < 0) y = 1;
    if (y > 1) y = 0;
  }
}

// رسام الجزيئات
class ParticlesPainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;
  final bool isDark;

  ParticlesPainter({
    required this.particles,
    required this.animation,
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    for (var particle in particles) {
      particle.update();

      paint.color = (isDark ? Colors.white : Colors.white).withOpacity(
        particle.opacity,
      );

      canvas.drawCircle(
        Offset(particle.x * size.width, particle.y * size.height),
        particle.size,
        paint,
      );
    }

    // رسم خطوط بين الجزيئات القريبة
    _drawConnections(canvas, size);
  }

  void _drawConnections(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = (isDark ? Colors.white : Colors.white).withOpacity(0.1);

    for (int i = 0; i < particles.length; i++) {
      for (int j = i + 1; j < particles.length; j++) {
        final dx = (particles[i].x - particles[j].x) * size.width;
        final dy = (particles[i].y - particles[j].y) * size.height;
        final distance = math.sqrt(dx * dx + dy * dy);

        if (distance < 100) {
          canvas.drawLine(
            Offset(particles[i].x * size.width, particles[i].y * size.height),
            Offset(particles[j].x * size.width, particles[j].y * size.height),
            linePaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => true;
}
