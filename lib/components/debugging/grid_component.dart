import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GridComponent extends Component {
  final double gridSize; // Size of each grid square
  final Paint gridPaint;
  final TextPaint textPaint;

  final Size size;

  GridComponent({this.gridSize = 50, required this.size})
      : gridPaint = Paint()
          ..color = Colors.grey.withOpacity(0.5)
          ..style = PaintingStyle.stroke,
        textPaint = TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );

  @override
  void render(Canvas canvas) {
    final width = size.width;
    final height = size.height;

    // Draw vertical grid lines
    for (double x = 0; x <= width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, height), gridPaint);
      textPaint.render(canvas, x.toStringAsFixed(0), Vector2(x + 2, 2));
    }
    // Draw horizontal grid lines
    for (double y = 0; y <= height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(width, y), gridPaint);
      textPaint.render(canvas, y.toStringAsFixed(0), Vector2(2, y + 2));
    }
  }
}
