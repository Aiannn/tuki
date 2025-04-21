import 'package:flame_forge2d/flame_forge2d.dart';

class TukiRayCastCallback extends RayCastCallback {
  Vector2? hitPoint;
  Vector2? hitNormal;

  @override
  double reportFixture(
    Fixture fixture,
    Vector2 point,
    Vector2 normal,
    double fraction,
  ) {
    hitPoint = point.clone();
    hitNormal = normal.clone();
    return fraction; // Take the first (nearest) hit
  }
}
