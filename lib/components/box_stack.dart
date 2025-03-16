import 'package:flame/components.dart';
import 'dart:math';
import 'tuki.dart';

class BoxStack extends PositionComponent with HasGameRef {
  final int numBoxes = 5; // Number of boxes
  final double boxSize = 25; // Box size
  final double tiltSpeed = 0.5; // Speed of tilt (adjustable)
  List<SpriteComponent> boxes = [];
  final Tuki tuki;
  double tiltAngle = 0; // Current tilt angle (counterclockwise)

  BoxStack(this.tuki);

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

    // Update tilt angle (oscillating counterclockwise)
    tiltAngle += tiltSpeed * dt;
    double tiltRadians = tiltAngle * (pi / 180); // Convert degrees to radians

    // Bottom box follows Tuki's shoulder
    Vector2 bottomBoxPos =
        tuki.position + Vector2(tuki.size.x / 2 - boxSize / 2, -boxSize);
    boxes[0].position = bottomBoxPos;

    // Rotate other boxes around the bottom one
    for (int i = 1; i < boxes.length; i++) {
      double radius = i * boxSize; // Distance from the bottom box
      double xOffset = sin(tiltRadians) * radius;
      double yOffset = -cos(tiltRadians) * radius; // Negative to move upwards

      boxes[i].position = boxes[0].position + Vector2(xOffset, yOffset);
      boxes[i].angle = tiltRadians; // Rotate the sprite
    }
  }
}
