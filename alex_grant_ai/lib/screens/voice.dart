import 'package:flutter/material.dart';
import 'dart:math' as math;

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({Key? key}) : super(key: key);

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background image
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/voice_background.png'),  // Your image path here
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.darken),  // Optional: Apply a dark filter
          ),
        ),
        child: Stack(
          children: [
            // Animated Wave Background
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  painter: WavePainter(
                    animation: _controller,
                    color: const Color(0xFF8B5CF6).withOpacity(0.05),
                  ),
                  size: Size.infinite,
                );
              },
            ),

            // Glowing Orb
            Center(
              child: SizedBox(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    // Outer glow
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8B5CF6).withOpacity(0.2),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),
                    // Inner orb with spiral effect
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: SpiralOrbPainter(
                            animation: _controller.value,
                          ),
                          size: const Size(120, 120),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Controls
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Center(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.pause, color: Colors.white, size: 24),
                        onPressed: () {},
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xFF1A1A1A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.mic, color: Colors.white, size: 24),
                      ),
                      IconButton(
                        icon: const Icon(Icons.call_end, color: Color(0xFFFF375F), size: 24),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SpiralOrbPainter extends CustomPainter {
  final double animation;

  SpiralOrbPainter({required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    // Base orb gradient
    final Paint orbPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFF375F).withOpacity(0.7),
          const Color(0xFF8B5CF6).withOpacity(0.3),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: size.width / 2));

    canvas.drawCircle(center, size.width / 2, orbPaint);

    // Spiral effect
    final Paint spiralPaint = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (double i = 0; i < 360; i += 30) {
      final path = Path();
      for (double j = 0; j < 360; j += 5) {
        final double angle = (j + animation * 360 + i) * math.pi / 180;
        final double radius = j / 360 * size.width / 2;
        final double x = center.dx + radius * math.cos(angle);
        final double y = center.dy + radius * math.sin(angle);

        if (j == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      canvas.drawPath(path, spiralPaint);
    }
  }

  @override
  bool shouldRepaint(SpiralOrbPainter oldDelegate) => true;
}

class WavePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  WavePainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    for (var i = 0; i < 5; i++) {
      final path = Path();
      final offset = i * 50.0;

      for (var x = 0.0; x < size.width; x += 1) {
        final y = size.height / 2 +
            math.sin((x + offset) / 30 + animation.value * math.pi * 2) * 50 *
                math.sin(x / 100);

        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}
