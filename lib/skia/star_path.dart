import 'dart:ui';
import 'dart:math';

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
  canvas
    ..scale(devicePixelRatio, devicePixelRatio)
    ..translate(100, 100)
    ..drawColor(Color(0xFFFFFFFF), BlendMode.color);

  final paint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round
    ..color = const Color(0xff4285F4);

  final guidesPaint = Paint()
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..strokeWidth = 1
    ..color = const Color(0xFF000000);

  Path starPath = star();
  canvas
    ..drawColor(Color(0xFF101010), BlendMode.color)
    ..drawLine(Offset.zero, Offset(0, logicalSize.height), guidesPaint)
    ..drawLine(Offset.zero, Offset(logicalSize.width, 0), guidesPaint);
  
  canvas.drawPath(starPath, paint);

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
