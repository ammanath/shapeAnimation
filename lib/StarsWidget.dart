import 'dart:math';
import 'package:flutter/material.dart';

class Stars extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StarsState();
  }
}

class _StarsState extends State<Stars> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Bubble> stars;
  final int numberOfStars = 1;
  final Color color = Colors.amber;
  final double maxStarsize = 20.0;

  @override
  void initState() {
    super.initState();

    // Initialize Stars
    stars = List();
    int i = numberOfStars;
    while (i > 0) {
      stars.add(Bubble(color, maxStarsize));
      i--;
    }

    // Init animation controller
    _controller = new AnimationController(
        duration: const Duration(seconds: 1000), vsync: this);
    _controller.addListener(() {
      updateBubblePosition();
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
    return Scaffold(
      body: CustomPaint(
        foregroundPainter: BubblePainter(stars: stars, controller: _controller),
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
      ),
    );
  }

  void updateBubblePosition() {
    stars.forEach((it) => it.updatePosition());
    setState(() {});
  }
}

class BubblePainter extends CustomPainter {
  List<Bubble> stars;
  AnimationController controller;

  BubblePainter({this.stars, this.controller});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    stars.forEach((it) => it.draw(canvas, canvasSize));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  Color colour;
  double direction;
  double speed;
  double radius;
  double x;
  double y;

  Bubble(Color colour, double maxStarsize) {
    this.colour = Colors.blue; //.withOpacity(Random().nextDouble());
    this.direction = Random().nextDouble() * 360;
    this.speed = 1;
    this.radius = 8;
   // Random().nextDouble() * maxStarsize;
    print('Direction : $direction , speed: $speed, radius: $radius ');
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = new Paint()
      ..color = colour
      ..strokeCap = StrokeCap.square
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    canvas.drawCircle(Offset(x, y), radius, paint);
    //canvas.drawRRect(RRect.fromRectAndRadius(        Rect.fromLTWH(x, y, x + 7, y * 2), Radius.circular(2.0)), paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    if (x == null) {
      this.x = Random().nextDouble() * canvasSize.width;
    }

    if (y == null) {
      this.y = Random().nextDouble() * canvasSize.height;
    }
  }

  updatePosition() {
    var a = 180 - (direction + 90);
    direction > 0 && direction < 180
        ? x += speed * sin(direction) / sin(speed)
        : x -= speed * sin(direction) / sin(speed);
    direction > 90 && direction < 270
        ? y += speed * sin(a) / sin(speed)
        : y -= speed * sin(a) / sin(speed);
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360;
    }
  }
}
