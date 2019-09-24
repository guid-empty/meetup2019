import 'dart:ui' as ui;

void main() {
  ui.window.onBeginFrame = beginFrame;
  ui.window.scheduleFrame();
}

void beginFrame(Duration timeStamp) {
  final double devicePixelRatio = ui.window.devicePixelRatio;
  final ui.Size logicalSize = ui.window.physicalSize / devicePixelRatio;

  final ui.Rect physicalBounds = ui.Offset.zero & (logicalSize * devicePixelRatio);
  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final ui.Canvas canvas = ui.Canvas(recorder, physicalBounds);
  canvas.scale(devicePixelRatio, devicePixelRatio);

  final paint = ui.Paint()
    ..color = const ui.Color.fromARGB(255, 255, 0, 0)
    ..strokeWidth = 4.0
    ..style = ui.PaintingStyle.fill
    ..strokeCap = ui.StrokeCap.round;

  final backgroundColor = const ui.Color(0xFFFFFFFF);
  final backgroundPaint = ui.Paint()
    ..color = backgroundColor
    ..strokeWidth = 4.0
    ..style = ui.PaintingStyle.fill
    ..strokeCap = ui.StrokeCap.round;

  final hornHeight = 168.0;
  final hornWidth = 222.0;

  final logoHeight = 280.0;
  final logoWidth = 280.0;
  final logoOffsetX = (logicalSize.width - logoWidth) / 2;
  final logoOffsetY = 100.0;

  final hornOffsetX = logoOffsetX + logoWidth / 2 - hornWidth / 2 + 24;
  double hornOffsetY = logoOffsetY + logoHeight / 2 + hornHeight / 2;

  canvas
    ..drawColor(backgroundColor, ui.BlendMode.color)
    ..drawRect(ui.Rect.fromLTWH(logoOffsetX, logoOffsetY, logoWidth, logoHeight), paint);

  canvas
    ..drawPath(
        ui.Path()
          ..moveTo(hornOffsetX, hornOffsetY)
          ..lineTo(hornOffsetX - 024, hornOffsetY - 50)
          ..lineTo(hornOffsetX + 000, hornOffsetY - 44)
          ..lineTo(hornOffsetX + 144, hornOffsetY - 168)
          ..lineTo(hornOffsetX + 198, hornOffsetY - 52)
          ..lineTo(hornOffsetX + 120, hornOffsetY - 42)
          ..lineTo(hornOffsetX + 118, hornOffsetY - 20)
          ..lineTo(hornOffsetX + 028, hornOffsetY - 08)
          ..lineTo(hornOffsetX + 022, hornOffsetY - 26)
          ..lineTo(hornOffsetX + 010, hornOffsetY - 22)
          ..lineTo(hornOffsetX + 000, hornOffsetY),
        backgroundPaint)
    ..drawPath(
        ui.Path()
          ..moveTo(hornOffsetX + 032, hornOffsetY - 28)
          ..lineTo(hornOffsetX + 034, hornOffsetY - 18)
          ..lineTo(hornOffsetX + 108, hornOffsetY - 30)
          ..lineTo(hornOffsetX + 106, hornOffsetY - 40)
          ..lineTo(hornOffsetX + 032, hornOffsetY - 28),
        paint);

  hornOffsetY += logoHeight + 20;
  canvas
    ..drawPoints(
        ui.PointMode.polygon,
        <ui.Offset>[
          ui.Offset(hornOffsetX, hornOffsetY),
          ui.Offset(hornOffsetX - 024, hornOffsetY - 50),
          ui.Offset(hornOffsetX + 000, hornOffsetY - 44),
          ui.Offset(hornOffsetX + 144, hornOffsetY - 168),
          ui.Offset(hornOffsetX + 198, hornOffsetY - 52),
          ui.Offset(hornOffsetX + 120, hornOffsetY - 42),
          ui.Offset(hornOffsetX + 118, hornOffsetY - 20),
          ui.Offset(hornOffsetX + 028, hornOffsetY - 08),
          ui.Offset(hornOffsetX + 022, hornOffsetY - 26),
          ui.Offset(hornOffsetX + 010, hornOffsetY - 22),
          ui.Offset(hornOffsetX + 000, hornOffsetY),
        ],
        paint)
    ..drawPath(
        ui.Path()
          ..moveTo(hornOffsetX + 032, hornOffsetY - 28)
          ..lineTo(hornOffsetX + 034, hornOffsetY - 18)
          ..lineTo(hornOffsetX + 108, hornOffsetY - 30)
          ..lineTo(hornOffsetX + 106, hornOffsetY - 40)
          ..lineTo(hornOffsetX + 032, hornOffsetY - 28),
        paint);

  final ui.Picture picture = recorder.endRecording();

  final ui.SceneBuilder sceneBuilder = ui.SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(ui.Offset.zero, picture)
    ..pop();

  ui.window.render(sceneBuilder.build());
}
