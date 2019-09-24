import 'dart:ui';
import 'package:vector_math/vector_math.dart';

void main() {
  window.onBeginFrame = beginFrame;
  window.scheduleFrame();
}

///
/// See more details on https://fiddle.skia.org/c/@rotations
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

  canvas
    ..translate(128, 100)
    ..rotate(radians(60));
  Rect rect = Rect.fromLTWH(0, 0, 200, 100);

  final paint = Paint()
    ..style = PaintingStyle.fill
    ..isAntiAlias = true
    ..color = const Color(0xff4285F4);

  canvas.drawRect(rect, paint);

  canvas.rotate(radians(20));
  paint.color = Color(0xffDB4437);
  canvas.drawRect(rect, paint);

  final Picture picture = recorder.endRecording();

  final SceneBuilder sceneBuilder = SceneBuilder()
    ..pushClipRect(physicalBounds)
    ..addPicture(Offset.zero, picture)
    ..pop();

  window.render(sceneBuilder.build());
}
