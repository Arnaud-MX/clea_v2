import 'package:flutter/material.dart';
import 'dart:math' as math;

class PercentileChart extends StatefulWidget {
  final double percentile;
  final bool animate;

  const PercentileChart({
    super.key,
    required this.percentile,
    this.animate = true,
  });

  @override
  State<PercentileChart> createState() => _PercentileChartState();
}

class _PercentileChartState extends State<PercentileChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: widget.percentile / 100,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          children: [
            SizedBox(
              height: 60,
              child: CustomPaint(
                size: const Size(double.infinity, 60),
                painter: PercentileBarPainter(
                  percentile: _animation.value,
                  theme: theme,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLabel(theme, '10%', 'Bottom'),
                _buildLabel(theme, '25%', 'Lower'),
                _buildLabel(theme, '50%', 'Median'),
                _buildLabel(theme, '75%', 'Upper'),
                _buildLabel(theme, '90%', 'Top'),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildLabel(ThemeData theme, String percentage, String label) {
    return Column(
      children: [
        Text(
          percentage,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}

class PercentileBarPainter extends CustomPainter {
  final double percentile;
  final ThemeData theme;

  PercentileBarPainter({
    required this.percentile,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    const double barHeight = 24;
    const double radius = 12;
    final double centerY = size.height / 2;
    
    // Background bar
    paint.color = theme.colorScheme.onSurface.withValues(alpha: 0.1);
    final backgroundRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, centerY - barHeight / 2, size.width, barHeight),
      const Radius.circular(radius),
    );
    canvas.drawRRect(backgroundRect, paint);

    // Segments
    final segmentWidth = size.width / 5;
    final segmentColors = [
      const Color(0xFFEF5350), // Red - Bottom 10%
      const Color(0xFFFF9800), // Orange - 10-25%
      const Color(0xFFFFC107), // Yellow - 25-50%
      const Color(0xFF66BB6A), // Light Green - 50-75%
      const Color(0xFF4CAF50), // Green - 75-90%
    ];

    for (int i = 0; i < 5; i++) {
      final segmentStart = i * segmentWidth;
      final segmentPercentile = (i + 1) * 0.2;
      
      if (percentile >= segmentPercentile - 0.001) {
        paint.color = segmentColors[i];
        final segmentRect = RRect.fromRectAndRadius(
          Rect.fromLTWH(
            segmentStart,
            centerY - barHeight / 2,
            segmentWidth - 2,
            barHeight,
          ),
          const Radius.circular(radius),
        );
        canvas.drawRRect(segmentRect, paint);
      }
    }

    // User position indicator
    final userPosition = percentile * size.width;
    paint.color = theme.colorScheme.surface;
    paint.style = PaintingStyle.fill;
    
    // Draw circle indicator
    canvas.drawCircle(
      Offset(userPosition, centerY),
      14,
      paint,
    );
    
    // Draw inner circle
    paint.color = theme.colorScheme.primary;
    canvas.drawCircle(
      Offset(userPosition, centerY),
      10,
      paint,
    );

    // Draw percentage text above indicator
    final textPainter = TextPainter(
      text: TextSpan(
        text: '${(percentile * 100).round()}%',
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    
    final textOffset = Offset(
      userPosition - textPainter.width / 2,
      centerY - barHeight / 2 - textPainter.height - 8,
    );
    textPainter.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(PercentileBarPainter oldDelegate) {
    return oldDelegate.percentile != percentile;
  }
}