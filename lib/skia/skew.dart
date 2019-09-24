import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

///
/// See more details on https://fiddle.skia.org/c/@Canvas_skew
///
void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder, physicalBounds);

  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..drawColor(Color(0xFFFFFFFF), BlendMode.color);

  final paint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 4
    ..color = Colors.black;

  canvas
    ..translate(100, 100)
    ..save()
    ..skew(-.5, 0);

  final ParagraphBuilder paragraphBuilder = ParagraphBuilder(ParagraphStyle(
    textAlign: TextAlign.start,
    textDirection: TextDirection.ltr,
    fontSize: 128,
  ))
    ..pushStyle(ui.TextStyle(foreground: paint))
    ..addText('A1');
  final Paragraph paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: logicalSize.width));
  canvas.drawParagraph(paragraph, Offset.zero);
  canvas.restore();

  canvas
    ..save()
    ..skew(-.5, .5);
  paint.color = Colors.red;
  paragraphBuilder
    ..pop()
    ..pushStyle(ui.TextStyle(foreground: paint))
    ..addText('A1');
  canvas
    ..drawParagraph(paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: logicalSize.width)), Offset.zero)
    ..restore();

  canvas
    ..save()
    ..skew(-.5, 1.1);
  paint.color = Colors.blue;
  paragraphBuilder
    ..pop()
    ..pushStyle(ui.TextStyle(foreground: paint))
    ..addText('A1');

  canvas
    ..drawParagraph(paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: logicalSize.width)), Offset.zero)
    ..restore();

  final Picture picture = recorder.endRecording();
  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
