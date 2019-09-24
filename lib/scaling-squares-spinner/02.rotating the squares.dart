import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:vector_math/vector_math_64.dart';

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

  final sideLength = 200.0;
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

  final angle = 45.0;
  final maxOffset = 200.0 + (angle / 360);
  final angleToRotate = radians(angle);

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushOffset(xCenter - maxOffset, yCenter - maxOffset)
    ..pushTransform((Matrix4.identity()..rotateZ(angleToRotate)).storage)
    ..pushOpacity(0x50)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pop()
    ..pushOffset(maxOffset * 2, 0)
    ..pushTransform((Matrix4.identity()..rotateZ(angleToRotate)).storage)
    ..pushOpacity(0x80)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pop()
    ..pushOffset(0, maxOffset * 2)
    ..pushTransform((Matrix4.identity()..rotateZ(angleToRotate)).storage)
    ..pushOpacity(0xDD)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pop()
    ..pushOffset(-maxOffset * 2, 0)
    ..pushTransform((Matrix4.identity()..rotateZ(angleToRotate)).storage)
    ..pushOpacity(0xFF)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pop();
  window.render(sceneBuilder.build());
}
