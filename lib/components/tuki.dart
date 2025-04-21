import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/components.dart';
import 'package:tuki_game/components/terrain.dart';
import 'package:tuki_game/components/helpers/tuki_raycast.dart';

class Tuki extends BodyComponent
    with ContactCallbacks, HasGameRef<Forge2DGame> {
  final Terrain terrain;
  late SpriteComponent spriteComponent;
  final double characterWidth = 50;
  final double characterHeight = 80;
  final double rayLength = 500;
  final double moveSpeed = 2.5;

  Tuki({required this.terrain});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    spriteComponent = SpriteComponent()
      ..sprite = await Sprite.load('player_walk1.png')
      ..size = Vector2(characterWidth, characterHeight)
      ..anchor = Anchor.bottomCenter;

    gameRef.add(spriteComponent);
  }

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..position = Vector2(50, 300)
      ..type = BodyType.kinematic
      ..fixedRotation = false; // ✅ Prevent unwanted rotation

    final body = world.createBody(bodyDef);

    final shape = PolygonShape()
      ..setAsBox(characterWidth / 2, characterHeight / 2, Vector2.zero(), 0);
    final fixtureDef = FixtureDef(shape);
    body.createFixture(fixtureDef);

    return body;
  }

  @override
  void update(double dt) {
    super.update(dt);

    final rayStart = body.position;
    final rayEnd = body.position + Vector2(0, rayLength); // Cast ray downward

    final callback = TukiRayCastCallback();
    world.raycast(callback, rayStart, rayEnd);

    if (callback.hitPoint != null && callback.hitNormal != null) {
      final newPos = callback.hitPoint!;
      final newAngle = callback.hitNormal!.angleTo(Vector2(0, -1)) * -1;

      body.setTransform(newPos, newAngle);
      spriteComponent.position = body.position;
      spriteComponent.angle = body.angle;
    }
  }

  @override
  void onRemove() {
    super.onRemove();
    spriteComponent.removeFromParent(); // ✅ Remove sprite when Tuki is removed
  }
}
