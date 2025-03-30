import 'dart:async';

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:fast_noise/fast_noise.dart'; // ✅ Correct import for fast_noise 2.0.0
import 'dart:math';
import 'package:flutter/painting.dart';

class Terrain extends BodyComponent {
  // ✅ Adjustable variables for terrain behavior
  final double
      segmentWidth; // ✅ Controls detail of terrain (smaller = sharper details)
  final double maxHeight; // ✅ Maximum height of hills
  final double terrainSpeed; // ✅ Controls how fast the terrain moves
  final double
      noiseFrequency; // ✅ Controls how often hills appear (higher = more hills)
  final double
      noiseMultiplier; // ✅ Controls steepness of slopes (higher = steeper)
  final double smoothingFactor; // ✅ Controls how much smoothing is applied

  final Paint terrainPaint = Paint()
    ..color = const Color(0xFFE3D0AF); // ✅ Terrain color

  final Completer<bool> isReady =
      Completer<bool>(); // ✅ Completer to signal when terrain is ready

  Terrain({
    this.segmentWidth = 20, // ✅ Change this for more/less detailed terrain
    this.maxHeight = 120, // ✅ Change this to make hills taller
    this.terrainSpeed = -2, // ✅ Change this to control terrain speed
    this.noiseFrequency = 0.075, // ✅ Change this for more/less frequent hills
    this.noiseMultiplier = 2, // ✅ Change this to make slopes steeper or gentler
    this.smoothingFactor = 0.9, // ✅ Change this to control terrain smoothness
  }) : super(paint: Paint()..color = const Color(0xFFE3D0AF));

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..position = Vector2(0, 500) // ✅ Base height
      ..type = BodyType.kinematic; // ✅ Moves but isn't affected by gravity

    final body = world.createBody(bodyDef);

    final List<Vector2> vertices =
        _generateTerrain(100, segmentWidth, maxHeight);

    final chainShape = ChainShape()..createChain(vertices);
    final fixtureDef = FixtureDef(chainShape)
      ..friction = 0.9
      ..restitution = 0.1; // ✅ Ground absorbs impact slightly

    body.createFixture(fixtureDef);
    isReady.complete(true); // Notify that terrain is ready
    return body;
  }

  List<Vector2> _generateTerrain(int segments, double width, double height) {
    final List<Vector2> points = [];

    // ✅ Correct way to use fast_noise 2.0.0
    final perlinNoise = PerlinNoise(
        frequency: noiseFrequency); // ✅ Adjust frequency dynamically

    double x = 0;
    double y = 0;
    final seed = Random().nextInt(10000); // ✅ Randomized terrain each session

    for (int i = 0; i < segments; i++) {
      double noiseValue = perlinNoise.getNoise2(i.toDouble(), seed.toDouble()) *
          noiseMultiplier;
      y = height * noiseValue; // ✅ Scale height within limits

      // ✅ Smooth out terrain using an adjustable smoothing factor
      if (i > 0) {
        double prevY = points[i - 1].y;
        y = (y * smoothingFactor) + (prevY * (1 - smoothingFactor));
      }

      points.add(Vector2(x, y));
      x += width;
    }
    return points;
  }

  @override
  void update(double dt) {
    super.update(dt);
    body.linearVelocity = Vector2(terrainSpeed, 0); // ✅ Smooth movement
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final shape =
        body.fixtures.first.shape as ChainShape; // ✅ Cast to ChainShape
    final Path path = Path();
    path.moveTo(0, 500);

    for (var point in shape.vertices) {
      // ✅ Now correctly accessing vertices
      path.lineTo(point.x, point.y);
    }

    path.lineTo(shape.vertices.last.x, 600); // ✅ Close shape
    path.close();
    canvas.drawPath(path, terrainPaint);
  }

  double getHeightAt(double x) {
    final shape =
        body.fixtures.first.shape as ChainShape; // ✅ Cast to ChainShape
    final vertices = shape.vertices; // ✅ Now we can access vertices safely

    if (vertices.isEmpty) {
      return 500; // Prevent out-of-bounds errors
    }

    int index = (x / segmentWidth).floor();
    if (index < 0) {
      return vertices
          .first.y; // Use the first terrain point instead of hardcoding 500
    }
    if (index >= vertices.length) {
      return vertices.last.y;
    }

    return 500 - vertices[index].y;
  }
}
