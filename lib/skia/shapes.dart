import 'dart:ui';

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
  final Canvas canvas = Canvas(recorder, physicalBounds);
  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..translate(0, 100)
    ..drawColor(Color(0xFFFFFFFF), BlendMode.color);

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
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
