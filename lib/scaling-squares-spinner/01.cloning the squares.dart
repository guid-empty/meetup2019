import 'dart:ui';

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

  final yCenter = physicalBounds.height / 2;
  final xCenter = physicalBounds.width / 2;

  final maxOffset = sideLength;

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushOffset(xCenter - maxOffset, yCenter - maxOffset)
    ..pushOpacity(0x50)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pushOffset(maxOffset * 2, 0)
    ..pushOpacity(0x80)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pushOffset(0, maxOffset * 2)
    ..pushOpacity(0xDD)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pushOffset(-maxOffset * 2, 0)
    ..pushOpacity(0xFF)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
