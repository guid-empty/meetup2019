import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/painting.dart';

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

  final SceneBuilder sceneBuilder = SceneBuilder();

  for (int i = 0; i < 30; i++) {
    final xRandFactor = math.Random().nextDouble();
    final yRandFactor = math.Random().nextDouble();

    final xOffset = physicalBounds.width * xRandFactor;
    final yOffset = physicalBounds.height * yRandFactor;
    sceneBuilder
      ..pushOffset(xOffset, yOffset)
      ..pushColorFilter(ColorFilter.mode(Color((0xFF000000 * xRandFactor).floor()), BlendMode.srcOut))
      ..addPicture(Offset.zero, picture)
      ..pop()
      ..pushOffset(-xOffset, -yOffset);
  }
  window.render(sceneBuilder.build());
  //window.scheduleFrame();
}
