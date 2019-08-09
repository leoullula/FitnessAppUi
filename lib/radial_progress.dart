import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as math;

class RadialProgress extends StatefulWidget {
  final double goalComp = 0.7;

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  AnimationController _radialProgressAnimationController;
  Animation<double> _progressAnimation;
  final Duration fadeInDuration = Duration(milliseconds: 500);
  final Duration fillDuration = Duration(seconds: 2);

  double progressDegrees = 0;

  @override
  void initState() {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0)
        .animate(
        CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
          ..addListener(() {
            setState(() {
              progressDegrees = widget.goalComp * _progressAnimation.value;
            });
          });
    _radialProgressAnimationController.forward();
  }
  @override
  void dispose()
  {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 150.0,
        width: 200.0, padding: EdgeInsets.symmetric(vertical: 3.0),
        child: AnimatedOpacity(
          opacity: progressDegrees > 30 ? 1.0 : 0.0,
          duration: fadeInDuration ,
          child: Column(
            children: <Widget>[
              Text(
                'RUNNING',
                style: TextStyle(fontSize: 16.0, letterSpacing: 1.5),
              ),
              SizedBox(
                height: 4.0,
              ),
              Container(
                height: 5.0,
                width: 80.0,
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                '1.225',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                'CALORIES BURN',
                style: TextStyle(
                    fontSize: 13.0, color: Colors.blue, letterSpacing: 1.5,
                fontStyle: FontStyle.italic ),
              ),
            ],
          ),
        ),
      ),
      painter: RadialPainter(this.progressDegrees),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDouble;

  RadialPainter(this.progressInDouble);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0; //..for calling directly
    Offset center = Offset(size.width / 2, size.height / 4);
    canvas.drawCircle(center, size.width / 2.5, paint);

    Paint linePaint = Paint()
      ..shader = LinearGradient(
              colors: [Colors.red, Colors.purple, Colors.pinkAccent])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2.5))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    canvas.drawArc(Rect.fromCircle(center: center, radius: size.width / 2.5),
        math.radians(-90), math.radians(progressInDouble), false, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
