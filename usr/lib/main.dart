import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stellarium Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SkyViewPage(),
    );
  }
}

class SkyViewPage extends StatefulWidget {
  const SkyViewPage({super.key});

  @override
  State<SkyViewPage> createState() => _SkyViewPageState();
}

class _SkyViewPageState extends State<SkyViewPage> {
  List<Star> _stars = [];
  final int _starCount = 500;

  @override
  void initState() {
    super.initState();
    _generateStars();
  }

  void _generateStars() {
    final random = Random();
    List<Star> stars = [];
    for (int i = 0; i < _starCount; i++) {
      stars.add(Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        radius: random.nextDouble() * 1.2 + 0.3,
        color: Colors.white.withOpacity(random.nextDouble() * 0.6 + 0.4),
      ));
    }
    setState(() {
      _stars = stars;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stellarium Clone'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: CustomPaint(
        painter: SkyPainter(stars: _stars),
        child: Container(),
      ),
    );
  }
}

class Star {
  final double x;
  final double y;
  final double radius;
  final Color color;

  Star({required this.x, required this.y, required this.radius, required this.color});
}

class SkyPainter extends CustomPainter {
  final List<Star> stars;

  SkyPainter({required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()..color = Colors.black;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    for (final star in stars) {
      final starPaint = Paint()..color = star.color;
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.radius,
        starPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant SkyPainter oldDelegate) {
    return oldDelegate.stars != stars;
  }
}
