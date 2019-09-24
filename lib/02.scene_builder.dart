import 'dart:ui';

import 'package:vector_math/vector_math_64.dart';
import 'package:flutter/painting.dart';

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

///
/// See more details on https://fiddle.skia.org/c/@shapes
///
void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder, physicalBounds)..scale(devicePixelRatio, devicePixelRatio);

  final paint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 4
    ..color = const Color(0xff4285F4);

  Rect rect = Rect.fromLTWH(10, 10, 100, 160);
  canvas.drawRect(rect, paint);

  Rect oval = rect.shift(Offset(40, 80));

  paint.color = Color(0xffDB4437);
  canvas.drawOval(oval, paint);

  paint.color = Color(0xff0F9D58);
  canvas.drawCircle(Offset(180, 50), 25, paint);

  rect = rect.shift(Offset(80, 50));
  paint
    ..color = Color(0xffF4B400)
    ..style = PaintingStyle.stroke;
  canvas.drawRRect(RRect.fromRectXY(rect, 10, 10), paint);

  final Picture picture = recorder.endRecording();

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushOffset(250, 250)
    ..pushOpacity(0x50)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pushOffset(50, 50)
    ..pushOpacity(0x80)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pushOffset(50, 50)
    ..pushOpacity(0xDD)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pushOffset(50, 50)
    ..pushOpacity(0xFF)
    ..addPicture(Offset.zero, picture)
    ..pop()
    ..pushOffset(0, 1000)
    ..pushOpacity(0xFF)
    ..pushTransform((Matrix4.identity()
          ..setEntry(3, 2, 0.002)
          ..rotateX(radians(10))
          ..rotateY(radians(10)))
        .storage)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
