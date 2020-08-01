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
      //updateBubblePosition();
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  GlobalKey _keyContainer = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Column(
        children: [
          Container(
              key: _keyContainer,
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: new Center(
                child: new Text(
                  "Rounded Corner Rectangle Shape",
                  style: TextStyle(color: Colors.white, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              )),
          Spacer(),
          Text('Test ${_getSizes()} , ${_getPositions()}'),
        ],
      ),

      // CustomPaint(
      //   foregroundPainter: BubblePainter(stars: stars, controller: _controller),
      //   size: Size(MediaQuery.of(context).size.width,
      //       MediaQuery.of(context).size.height),
      // ),
    );
  }

  Size _getSizes() {
    final RenderBox renderBoxContainer =
        _keyContainer.currentContext.findRenderObject();
    final sizeContainer = renderBoxContainer.size;
    print("SIZE of Container: $sizeContainer");
    return sizeContainer;
  }

  Offset _getPositions() {
    final RenderBox renderBoxContainer =
        _keyContainer.currentContext.findRenderObject();
    final positionContainer = renderBoxContainer.localToGlobal(Offset.zero);
    print("POSITION of Container: $positionContainer ");
    return positionContainer;
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
    this.colour = Colors.red;
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
    x ??= 0;
    y ??= 0;
    direction > 0 && direction < 180
        ? x += speed * sin(direction) / sin(speed)
        : x -= speed * sin(direction) / sin(speed);
    direction > 90 && direction < 270
        ? y += speed * sin(a) / sin(speed)
        : y -= speed * sin(a) / sin(speed);
    print('Direction : $direction , x: $x, y: $y ');
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if (x > canvasSize.width || x < 0 || y > canvasSize.height || y < 0) {
      direction = Random().nextDouble() * 360;
    }
  }
}
