import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

Duration start;
Duration previousFrame;
void main() {
  previousFrame = Duration.zero;
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}


void beginFrame(Duration timeStamp) {
  start ??= timeStamp;
  final diff = (timeStamp - previousFrame).inMicroseconds;
  previousFrame = timeStamp;

  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder, physicalBounds);

  const Color background = Colors.white; // SK_ColorTRANSPARENT;

  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..drawColor(background, BlendMode.color);

  final shapePaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round
    ..color = Colors.blue;

  final radius = 50.0;
  final x = logicalSize.width / 2;
  final initialY = 10;

  var segment = (timeStamp - start).inMilliseconds /
      (Duration.millisecondsPerSecond * 3);
  segment = segment > 1 ? 1 : segment;
  double restPath = (logicalSize.height - radius - initialY) * segment;

  canvas.drawCircle(Offset(x, initialY + restPath), radius, shapePaint);

  final ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(
    textAlign: TextAlign.start,
    textDirection: TextDirection.ltr,
    fontSize: 20,
  ))
    ..pushStyle(ui.TextStyle(foreground: shapePaint))
    ..addText(diff.toString());
  final Paragraph paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: logicalSize.width));
  canvas.drawParagraph(paragraph, Offset(x + radius, initialY + restPath - 10));

  final Picture picture = recorder.endRecording();
  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
  if (segment < 1) {
    window.scheduleFrame();
  }
}
