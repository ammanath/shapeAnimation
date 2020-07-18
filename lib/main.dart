import 'package:flutter/material.dart';
import 'package:stars_animate/StarsWidget.dart';
import 'package:stars_animate/bubblesWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stars',
      home: SimpleAnimation(),
    );
  }
}

class SimpleAnimation extends StatefulWidget {
  @override
  _SimpleAnimationState createState() => _SimpleAnimationState();
}

class _SimpleAnimationState extends State<SimpleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation colorAnimation;
  Animation sizeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..forward().orCancel;
    _controller.repeat(reverse: true);
    colorAnimation =
        ColorTween(begin: Colors.red, end: Colors.yellow).animate(_controller);
    sizeAnimation =
        Tween<double>(begin: 100.0, end: 200.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int percent = (_controller.value * 100.0).round();
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.all(3),
        child: SafeArea(
          child: new Center(
            child: Column(
              children: [
                Text('$percent%'),
                //Text('${_controller.value}'),
                Container(
                  height: percent.toDouble(),
                  width: percent.toDouble(),
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: colorAnimation.value,
                  ),
                  child: Center(
                    child: Text('You Won!'),
                  ),
                ),
                Container(
                    height: sizeAnimation.value,
                    width: sizeAnimation.value,
                    color: colorAnimation.value,
                    child: Center(
                      child: Text('You Lost!'),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
