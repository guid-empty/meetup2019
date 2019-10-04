import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as Vector;

void main() => runApp(MyApp());

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) =>
      Path()..addOval(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2 + 100), radius: 80));

  @override
  bool shouldReclip(CircleClipper oldClipper) => true;
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Color(0xFF00A651)
      ..strokeWidth = 10;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 10,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.orange.shade100,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class WavePainter extends CustomPainter {
  AnimationController animationController;

  WavePainter({this.animationController});

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> polygonOffsets = [];
    for (int i = 0; i <= size.width.toInt(); i++) {
      polygonOffsets.add(Offset((animationController?.value ?? 0) * 100 + i.toDouble(),
          math.sin(3 * i % 360 * Vector.degrees2Radians) * 20 + size.height));
    }
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Color(0xFF072946)
      ..strokeWidth = 10;

    canvas.drawPath(
        Path()
          ..addPolygon(polygonOffsets, false)
          ..lineTo(size.width, size.height + 200)
          ..lineTo(0.0, size.height + 200)
          ..close(),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    //return getStep01(context);
    //return getStep02(context);
    //return getStep03(context);
    //return getStep04(context);
    //return getStep05(context);

    return getStep06(context);
  }

  Widget getStep01(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: Colors.orange.shade100,
      child: Stack(children: [
        Positioned(
          top: (size.height / 2 - 200),
          left: 0,
          height: 200,
          width: size.width,
          child: CustomPaint(
            painter: WavePainter(),
          ),
        ),
      ]),
    );
  }

  Widget getStep02(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.orange.shade100,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Stack(children: [
                Positioned(
                  top: (size.height / 2 - 100),
                  left: size.width / 2 - 100,
                  child: CustomPaint(
                    size: Size(200, 200),
                    painter: CirclePainter(),
                  ),
                ),
              ])),
    );
  }

  Widget getStep03(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.orange.shade100,
      child: Stack(children: [
        Positioned(
          top: (size.height / 2 - 200),
          left: 0,
          height: 200,
          width: size.width,
          child: CustomPaint(
            painter: WavePainter(),
          ),
        ),
        Positioned(
          top: (size.height / 2 - 100),
          left: size.width / 2 - 100,
          child: CustomPaint(
            size: Size(200, 200),
            painter: CirclePainter(),
          ),
        ),
      ]),
    );
  }

  Widget getStep04(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.orange.shade100,
      child: Stack(
        children: [
          Positioned(
            top: (size.height / 2 - 200),
            left: 0,
            height: 200,
            width: size.width,
            child: ClipPath(
              clipper: CircleClipper(),
              child: CustomPaint(
                size: Size(200, 200),
                painter: WavePainter(),
              ),
            ),
          ),
          Positioned(
            top: (size.height / 2 - 100),
            left: size.width / 2 - 100,
            child: CustomPaint(
              size: Size(200, 200),
              painter: CirclePainter(),
            ),
          ),
        ],
      ),
    );
  }

  Widget getStep05(BuildContext context) {
    final size = MediaQuery.of(context).size;
    animationController.repeat();
    return Container(
      color: Colors.orange.shade100,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Stack(
          children: [
            Positioned(
              top: (size.height / 2 - 200),
              left: 0,
              height: 200,
              width: size.width,
              child: CustomPaint(
                size: Size(200, 200),
                painter: WavePainter(animationController: animationController),
              ),
            ),
            Positioned(
              top: (size.height / 2 - 100),
              left: size.width / 2 - 100,
              child: CustomPaint(
                size: Size(200, 200),
                painter: CirclePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getStep06(BuildContext context) {
    final size = MediaQuery.of(context).size;
    animationController.repeat();
    return Container(
      color: Colors.orange.shade100,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Stack(
          children: [
            Positioned(
              top: (size.height / 2 - 200),
              left: 0,
              height: 200,
              width: size.width,
              child: ClipPath(
                clipper: CircleClipper(),
                child: CustomPaint(
                  size: Size(200, 200),
                  painter: WavePainter(animationController: animationController),
                ),
              ),
            ),
            Positioned(
              top: (size.height / 2 - 100),
              left: size.width / 2 - 100,
              child: CustomPaint(
                size: Size(200, 200),
                painter: CirclePainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2), upperBound: 1);
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.decelerate,
    );
    animationController.repeat();
  }
}
