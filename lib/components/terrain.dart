import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class Terrain extends ParallaxComponent {
  final double speed;

  Terrain(this.speed);

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
}
