import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

///
/// See more details on https://fiddle.skia.org/c/@bezier_curves
///
void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder, physicalBounds);
  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..translate(0, 100);

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 8
    ..strokeCap = StrokeCap.round
    ..color = const Color(0xff4285F4);

  final markerPsaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round
    ..color = Colors.redAccent.shade200;

  final coordinatesPaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..color = Colors.red.shade200;

  Path path = Path()
    ..moveTo(10, 10)
    ..quadraticBezierTo(256, 64, 128, 128)
    ..quadraticBezierTo(10, 192, 250, 250);
  canvas
    ..drawPath(path, paint)
    ..translate(0, 0)
    ..drawLine(Offset(10, 10), Offset(256, 64), coordinatesPaint)
    ..translate(256, 64)
    ..drawCircle(Offset.zero, 10, markerPsaint)
    ..translate(-256, -64)
    ..drawLine(Offset(256, 64), Offset(128, 128), coordinatesPaint)
    ..translate(128, 128)
    ..drawCircle(Offset.zero, 10, markerPsaint)
    ..translate(-128, -128)
    ..drawLine(Offset(128, 128), Offset(10, 192), coordinatesPaint)
    ..translate(10, 192)
    ..drawCircle(Offset.zero, 10, markerPsaint)
    ..translate(-10, -192)
    ..drawLine(Offset(10, 192), Offset(250, 250), coordinatesPaint)
    ..translate(250, 250)
    ..drawCircle(Offset.zero, 10, markerPsaint);

  final Picture picture = recorder.endRecording();

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
