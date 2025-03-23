import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class Background extends ParallaxComponent {
  final double speed;

  Background(this.speed);

  @override
  Future<void> onLoad() async {
    parallax = await Parallax.load(
      [
        ParallaxImageData('back-1.jpg'),
      ],
      baseVelocity: Vector2(speed, 0), // Moves right
      repeat: ImageRepeat.repeatX,
    );
  }

  void stopMoving() {
    parallax?.baseVelocity = Vector2.zero(); // Stop movement
  }

  void resumeMoving() {
    parallax?.baseVelocity = Vector2(speed, 0); // Resume movement
  }
}
