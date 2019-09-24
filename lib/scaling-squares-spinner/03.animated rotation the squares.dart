import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math' as math;

Duration start;
Duration previousFrame;
bool isReversed = false;

void main() {
  previousFrame = Duration.zero;

  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

void beginFrame(Duration timeStamp) {
  start ??= timeStamp;
  previousFrame = timeStamp;

  var totalMsWithFraction = (timeStamp - start).inMilliseconds / Duration.millisecondsPerSecond;
  totalMsWithFraction = totalMsWithFraction > 1 ? 1 : totalMsWithFraction;

  if (totalMsWithFraction == 1) {
    start = timeStamp;
    isReversed = !isReversed;
  }

  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder);

  final maxSideLength = 300.0;
  double sideLength =
      isReversed ? (1 - totalMsWithFraction % 1.0) * maxSideLength : (totalMsWithFraction % 1.0) * maxSideLength;
  sideLength = sideLength > 50 ? sideLength : 50;

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 20
    ..color = const Color(0xff4285F4);

  Rect rect = Rect.fromLTWH(-(sideLength / 2), -(sideLength / 2), sideLength, sideLength);
  canvas.drawRect(rect, paint);

  final Picture picture = recorder.endRecording();

  final yCenter = physicalBounds.height / 2;
  final xCenter = physicalBounds.width / 2;

  final angleToRotate =
      isReversed ? math.pi / 2 * (1 + totalMsWithFraction % 1.0) : math.pi / 2 * (totalMsWithFraction % 1.0);
  double maxOffset =
      isReversed ? sideLength / 2 * (1 - totalMsWithFraction % 1.0) : sideLength / 2 * (totalMsWithFraction % 1.0);

  maxOffset = maxOffset *2;

  final rotationMatrix = (Matrix4.identity()..rotateZ(angleToRotate)).storage;
  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushOffset(xCenter - maxOffset, yCenter - maxOffset)
    ..pushTransform(rotationMatrix)
    ..pushOpacity(0xDD)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pop()
    ..pushOffset(maxOffset * 2, 0)
    ..pushTransform(rotationMatrix)
    ..pushOpacity(0xDD)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pop()
    ..pushOffset(0, maxOffset * 2)
    ..pushTransform(rotationMatrix)
    ..pushOpacity(0xDD)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pop()
    ..pushOffset(-maxOffset * 2, 0)
    ..pushTransform(rotationMatrix)
    ..pushOpacity(0xDD)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pop();

  window
    ..render(sceneBuilder.build())
    ..scheduleFrame();
}
