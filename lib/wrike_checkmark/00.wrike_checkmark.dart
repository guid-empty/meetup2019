import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

///
/// wrike logo is svg icon described as
///
/// <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 800 399">
/// <title>checkmark_digital_rgb</title>
/// <g id="Layer_1" data-name="Layer 1">
/// <rect width="400" height="400" fill="#072946"/>
/// <polygon points="259.61 112.27 124.35 247.53 164.54 287.73 340 112.27 259.61 112.27" fill="#00a651"/>
/// <polygon points="140.39 183.19 60 183.19 164.54 287.73 204.74 247.53 140.39 183.19" fill="#a6ce39"/>
/// </g>
/// </svg>
void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder);

  final coordinatesPaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..color = Colors.red.shade200;

  final centerX = physicalBounds.width / 2;
  final centerY = physicalBounds.height / 2;

  canvas
    ..drawColor(Color(0xff072946), BlendMode.color)
    ..translate(centerX - 200, centerY - 200)
    ..drawRect(Rect.fromLTRB(0, 0, 400, 400), coordinatesPaint)
    ..drawPath(
        Path()
          ..moveTo(259.61, 112.27)
          ..lineTo(124.35, 247.53)
          ..lineTo(164.54, 287.73)
          ..lineTo(340, 112.27)
          ..lineTo(259.61, 112.27),
        Paint()
          ..style = PaintingStyle.fill
          ..isAntiAlias = true
          ..color = const Color(0xFF00A651))
    ..drawPath(
        Path()
          ..moveTo(140.39, 183.19)
          ..lineTo(60, 183.19)
          ..lineTo(164.54, 287.73)
          ..lineTo(204.74, 247.53)
          ..lineTo(140.39, 183.19),
        Paint()
          ..style = PaintingStyle.fill
          ..isAntiAlias = true
          ..color = const Color(0xFFA6CE39));

  canvas
    ..translate(-centerX + 200, -centerY + 200)
    ..drawLine(Offset(centerX, 0), Offset(centerX, physicalBounds.height), coordinatesPaint)
    ..drawLine(Offset(0, centerY), Offset(physicalBounds.width, centerY), coordinatesPaint);
  final Picture picture = recorder.endRecording();

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushOffset(0, 0)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
