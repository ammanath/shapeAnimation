import 'package:flutter/material.dart';
import 'package:stars_animate/StarsWidget.dart';
import 'package:stars_animate/bubblesWidget.dart';
import 'package:stars_animate/triangles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animations",
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = <Widget>[
    Stars(),
    Container(
      child:SimpleAnimation()
    ),
    Container(
      child:TrianglesWidget()
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animations!!!'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline),
            title: Text('Bubbles'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            title: Text('Simple'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            title: Text('Triangles'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
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
    //startAnimation();

    _controller = new AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
  }

  void startAnimation() {
    _controller
      ..addListener(() {
        setState(() {});
      });
    _controller..forward().orCancel;
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
      body: Container(
        padding: EdgeInsets.all(3),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          buildAnimWidget(percent),
          RaisedButton(
            onPressed: () => startAnimate(),
            child: Text('Start', style: TextStyle(fontSize: 20)),
          ),
          RaisedButton(
            onPressed: () => stopAnimate(),
            child: Text('Stop', style: TextStyle(fontSize: 20)),
          ),
        ]),
      ),
    );
  }

  void stopAnimate() {
    _controller.stop();
  }

  Widget buildAnimWidget(int percent) {
    Widget wdgt;
    if (sizeAnimation == null) {
      wdgt = Text('Not Initialized');
    } else {
      wdgt = Center(
        child: Column(
          children: [
            Text('$percent%'),
            Container(
              height: percent.toDouble(),
              width: percent.toDouble(),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: colorAnimation?.value,
              ),
              child: Center(
                child: Text('Oooooh'),
              ),
            ),
            Container(
                height: sizeAnimation?.value,
                width: sizeAnimation?.value,
                color: colorAnimation?.value,
                child: Center(
                  child: Text('Zoooom!'),
                )),
          ],
        ),
      );
    }
    return wdgt;
  }

  startAnimate() {
    startAnimation();
  }
}
