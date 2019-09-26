import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart' as material;

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

///
/// See more details on https://fiddle.skia.org/c/@shader
///
void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder, physicalBounds);
  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..translate(0, 100)
    ..drawColor(Color(0xFFFFFFFF), BlendMode.color);

  final paint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round
    ..color = const Color(0xff4285F4)
    ..shader = Gradient.linear(Offset.zero, Offset(200, 0),
        <Color>[
          material.Colors.red,
          material.Colors.blue], null, TileMode.clamp);

  Path path = star();
  canvas.drawPath(path, paint);

  final Picture picture = recorder.endRecording();

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}

Path star() {
  const double R = 115.2, C = 128.0;
  final path = Path()..moveTo(C + R, C);
  for (int i = 1; i < 8; ++i) {
    double a = 2.6927937 * i;
    path.lineTo(C + R * cos(a), C + R * sin(a));
  }
  return path;
}
