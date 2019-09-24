import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math' as math;

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder);

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 20
    ..color = const Color(0xff4285F4);

  Rect rect = Rect.fromLTRB(-100, -100, 100, 100);
  canvas.drawRect(rect, paint);

  final Picture picture = recorder.endRecording();

  final double t = timeStamp.inMilliseconds / Duration.millisecondsPerSecond;
  final angleToRotate = math.pi * (t % 1.0);

  final yCenter = physicalBounds.height / 2;
  final xCenter = physicalBounds.width / 2;

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushOffset(xCenter, yCenter)
    ..pushTransform((Matrix4.identity()..rotateZ(angleToRotate)).storage)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window
    ..render(sceneBuilder.build())
    ..scheduleFrame();
}
