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
  final Canvas canvas = Canvas(recorder, physicalBounds);
  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..drawColor(Color(0xFFFFFFFF), BlendMode.color);

  final width = 200.0;
  final height = 200.0;
  final left = logicalSize.width / 2 - width / 2;
  final top = 100.0;
  Rect rect = Rect.fromLTWH(left, top, width, height);

  final paint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..color = const Color(0xffDB4437);

  final matrix = Matrix4.identity()
    ..setEntry(3, 2, 0.006)
    ..rotateX(radians(10))
    ..rotateY(radians(10));
  canvas.drawRect(rect, paint);

  canvas.transform(matrix.storage);

  rect = rect.shift(Offset(0, 400));
  canvas.drawRect(rect, paint..color = Color(0xFF0000FF));

  final Picture picture = recorder.endRecording();

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
