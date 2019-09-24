import 'dart:ui';

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
  canvas.scale(devicePixelRatio, devicePixelRatio);

  final backgroundColor = const Color(0xFFFFFFFF);
  final paint = Paint()
    ..color = const Color.fromARGB(255, 255, 0, 0)
    ..strokeWidth = 10.0
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;

  canvas
    ..drawColor(backgroundColor, BlendMode.color)
    ..drawLine(Offset.zero, Offset(0, logicalSize.height), paint)
    ..drawLine(Offset.zero, Offset(logicalSize.width, 0), paint)
    ..drawLine(Offset.zero, Offset(logicalSize.width, logicalSize.height), paint);

  final Picture picture = recorder.endRecording();

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
