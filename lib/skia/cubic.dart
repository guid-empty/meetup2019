import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

///
/// See more details on https://fiddle.skia.org/c/@SkPath_cubicTo_example
///
void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = window.devicePixelRatio;
  final Size logicalSize = window.physicalSize / devicePixelRatio;

  final Rect physicalBounds = Offset.zero & (logicalSize * devicePixelRatio);
  final PictureRecorder recorder = PictureRecorder();
  final Canvas canvas = Canvas(recorder, physicalBounds);
  const fontSize = 30.0;

  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..translate(0, 100)
    ..drawColor(Color(0xFFFFFFFF), BlendMode.color);

  final labelPaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round
    ..color = Colors.lightGreenAccent;

  final linePaint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..strokeWidth = 4
    ..strokeCap = StrokeCap.round
    ..color = Colors.black;

  final cubicPaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 8
    ..strokeCap = StrokeCap.round
    ..color = Colors.blue.shade700;

  final a = Offset(80, 64);
  final b = Offset(logicalSize.width - 20, 448);
  final c = Offset(20, 448);
  final d = Offset(logicalSize.width - 80, 64);

  canvas.drawParagraph(
      (ParagraphBuilder(ParagraphStyle(fontSize: fontSize))
            ..pushStyle(ui.TextStyle(foreground: labelPaint))
            ..addText('a'))
          .build()
            ..layout(ui.ParagraphConstraints(width: 10)),
      a);

  canvas.drawParagraph(
      (ParagraphBuilder(ParagraphStyle(fontSize: fontSize))
            ..pushStyle(ui.TextStyle(foreground: labelPaint))
            ..addText('b'))
          .build()
            ..layout(ui.ParagraphConstraints(width: 10)),
      b);

  canvas.drawParagraph(
      (ParagraphBuilder(ParagraphStyle(fontSize: fontSize))
            ..pushStyle(ui.TextStyle(foreground: labelPaint))
            ..addText('c'))
          .build()
            ..layout(ui.ParagraphConstraints(width: 10)),
      c);

  canvas.drawParagraph(
      (ParagraphBuilder(ParagraphStyle(fontSize: fontSize))
            ..pushStyle(ui.TextStyle(foreground: labelPaint))
            ..addText('d'))
          .build()
            ..layout(ui.ParagraphConstraints(width: 10)),
      d);

  canvas.drawPoints(PointMode.polygon, [a, b, c, d], linePaint);

  Path path = Path()
    ..moveTo(a.dx, a.dy)
    ..cubicTo(b.dx, b.dy, c.dx, c.dy, d.dx, d.dy);
  canvas.drawPath(path, cubicPaint);

  final Picture picture = recorder.endRecording();
  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
