import 'package:alex_grant_ai/screens/login.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SuccessDialog extends StatefulWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  State<SuccessDialog> createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _checkAnimation;
  late List<Particle> particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _checkAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Create particles
    particles = List.generate(6, (index) {
      final random = math.Random();
      return Particle(
        random.nextDouble() * 2 * math.pi,
        random.nextDouble() * 20 + 40,
      );
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: Stack(
                children: [
                  // Animated particles
                  ...particles.map((particle) => AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final progress = _controller.value;
                      final angle = particle.initialAngle + progress * 2 * math.pi;
                      final radius = particle.radius * progress;

                      return Positioned(
                        left: 60 + radius * math.cos(angle),
                        top: 60 + radius * math.sin(angle),
                        child: Opacity(
                          opacity: (1 - progress),
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Color(0xFF8E44AD),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
                  // Check mark circle
                  Center(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Color(0xFF8E44AD),
                        shape: BoxShape.circle,
                      ),
                      child: AnimatedBuilder(
                        animation: _checkAnimation,
                        builder: (context, child) {
                          return CustomPaint(
                            painter: CheckmarkPainter(
                              progress: _checkAnimation.value,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Password Successfully\nUpdated!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print('Button clicked!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(), // Replace NewPage with your desired page
                    ),
                  );
                  // Add your onTap logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E44AD),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Login to Your Account',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

class Particle {
  final double initialAngle;
  final double radius;

  Particle(this.initialAngle, this.radius);
}

class CheckmarkPainter extends CustomPainter {
  final double progress;
  final Color color;

  CheckmarkPainter({
    required this.progress,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Calculate checkmark points
    final start = Offset(size.width * 0.2, size.height * 0.5);
    final mid = Offset(size.width * 0.4, size.height * 0.7);
    final end = Offset(size.width * 0.8, size.height * 0.3);

    if (progress < 0.5) {
      // Draw first line
      final endPoint = Offset.lerp(start, mid, progress * 2)!;
      path.moveTo(start.dx, start.dy);
      path.lineTo(endPoint.dx, endPoint.dy);
    } else {
      // Draw complete checkmark
      path.moveTo(start.dx, start.dy);
      path.lineTo(mid.dx, mid.dy);
      final endPoint = Offset.lerp(mid, end, (progress - 0.5) * 2)!;
      path.lineTo(endPoint.dx, endPoint.dy);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CheckmarkPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}