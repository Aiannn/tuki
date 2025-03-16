import 'package:flame/components.dart';

class Tuki extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('player_walk1.png');
    size = Vector2(75, 100); // Adjust based on asset
    position = Vector2(size.x * 0.3, size.y * 6); // Bottom LEFT with margin
  }
}
