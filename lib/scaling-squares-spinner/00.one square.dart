import 'dart:ui';

import 'package:flutter/material.dart';
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

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 20
    ..color = const Color(0xff4285F4);

  final centerX = physicalBounds.width / 2;
  final centerY = physicalBounds.height / 2;
  final coordinatesPaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..color = Colors.red.shade200;

  Rect rect = Rect.fromLTRB(-100, -100, 100, 100);
  canvas
    ..translate(centerX, centerY)
    ..drawRect(rect, paint)
    ..translate(-centerX, -centerY)
    ..drawLine(Offset(centerX, 0), Offset(centerX, physicalBounds.height), coordinatesPaint)
    ..drawLine(Offset(0, centerY), Offset(physicalBounds.width, centerY), coordinatesPaint);

  final Picture picture = recorder.endRecording();

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushOffset(0, 0)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
