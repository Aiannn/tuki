import 'package:flame/components.dart';
import 'dart:math';
import 'tuki.dart';

class BoxStack extends PositionComponent with HasGameRef {
  final int numBoxes = 5; // Number of boxes
  final double boxSize = 25; // Box size
  final double tiltSpeed = 20; // Speed of automatic counterclockwise tilt
  final double tapTiltAmount =
      10; // ✅ How much tilt is added per tap (adjustable)

  List<SpriteComponent> boxes = [];
  final Tuki tuki;
  double tiltAngle = 90; // Current tilt angle (counterclockwise)

  BoxStack(this.tuki);

  void tiltClockwise() {
    tiltAngle -= tapTiltAmount; // ✅ Reduce angle → tilts clockwise
  }

  @override
  Future<void> onLoad() async {
    for (int i = 0; i < numBoxes; i++) {
      SpriteComponent box = SpriteComponent()
        ..sprite = await Sprite.load('box.png')
        ..size = Vector2(boxSize, boxSize);

      boxes.add(box);
      add(box);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // ✅ Apply automatic counterclockwise tilt
    tiltAngle += tiltSpeed * dt;
    double tiltRadians = tiltAngle * (pi / 180); // Convert degrees to radians

    // Bottom box follows Tuki's shoulder and tilts
    Vector2 basePos =
        tuki.position + Vector2(tuki.size.x / 2 - boxSize / 2, -boxSize);
    boxes[0].position = basePos;
    boxes[0].angle = tiltRadians; // Bottom box tilts

    // Tilt each box relative to the bottom box
    for (int i = 1; i < boxes.length; i++) {
      double radius = i * boxSize; // Distance from the bottom box
      double xOffset = cos(tiltRadians) * radius; // Counterclockwise tilt
      double yOffset =
          -sin(tiltRadians) * radius; // Adjust for natural stacking

      boxes[i].position = boxes[0].position + Vector2(xOffset, yOffset);
      boxes[i].angle = tiltRadians; // Apply same tilt to maintain stacking
    }
  }
}
