import 'dart:math';
import 'package:flutter/material.dart';

class ZefenFancyLoader extends StatefulWidget {
  const ZefenFancyLoader({super.key});

  @override
  _ZefenFancyLoaderState createState() => _ZefenFancyLoaderState();
}

class _ZefenFancyLoaderState extends State<ZefenFancyLoader>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _bubblesController;

  @override
  void initState() {
    super.initState();

    // Ripple Animation
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Bubbles Animation
    _bubblesController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _bubblesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Ripple
          AnimatedBuilder(
            animation: _rippleController,
            builder: (context, child) {
              return CustomPaint(
                painter: RipplePainter(_rippleController.value),
                size: const Size(200, 200),
              );
            },
          ),

          // Bubbling Musical Notes Animation
          AnimatedBuilder(
            animation: _bubblesController,
            builder: (context, child) {
              return CustomPaint(
                painter: MusicalNotesPainter(_bubblesController.value),
                size: const Size(200, 200),
              );
            },
          ),

          // Center PNG (replacing the 'Z')
          Image.asset(
            'assets/z_icon.png', // Path to your PNG file
            height: 120,
            width: 120,
          ),
        ],
      ),
    );
  }
}

class RipplePainter extends CustomPainter {
  final double progress;
  RipplePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint ripplePaint = Paint()
      ..color = Colors.deepPurple.withOpacity(1 - progress)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    double maxRadius = size.width / 2;
    double currentRadius = progress * maxRadius;

    // Draw the ripple
    canvas.drawCircle(size.center(Offset.zero), currentRadius, ripplePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class MusicalNotesPainter extends CustomPainter {
  final double progress;

  MusicalNotesPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Bubble animation parameters
    int bubbleCount = 6; // Total number of notes
    double maxRadius = size.width / 2; // Maximum distance from the center

    // Directions: Northeast and Northwest
    final directions = [
      pi / 4, // Northeast
      3 * pi / 4, // Northwest
    ];

    for (int i = 0; i < bubbleCount; i++) {
      // Select random direction: NE or NW
      double angle = directions[i % 2];
      double radius = progress * maxRadius * (1 + i * 0.2); // Spread bubbles

      double x = size.width / 2 + radius * cos(angle);
      double y = size.height / 2 - radius * sin(angle);

      // Draw each music note
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '♪', // Music note symbol
          style: TextStyle(
            fontSize: 30 * (1 - progress), // Shrink as they rise
            color: const Color.fromARGB(255, 74, 25, 148)
                .withOpacity(1 - progress), // Update color here
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - 8, y - 8)); // Center the note
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
