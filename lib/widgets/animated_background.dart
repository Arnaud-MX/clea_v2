import 'package:flutter/material.dart';
import 'dart:math' as math;

enum BackgroundIntensity {
  subtle,    // Animation très discrète pour les écrans avec beaucoup de contenu
  normal,    // Animation standard pour l'onboarding
  dynamic,   // Animation plus présente pour les écrans de célébration
}

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final bool enableAnimation;
  final BackgroundIntensity intensity;
  
  const AnimatedBackground({
    super.key,
    required this.child,
    this.enableAnimation = true,
    this.intensity = BackgroundIntensity.normal,
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _primaryController;
  late AnimationController _secondaryController;
  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    
    if (widget.enableAnimation) {
      // Contrôleur principal pour les formes organiques (cycle lent)
      _primaryController = AnimationController(
        duration: const Duration(seconds: 25),
        vsync: this,
      )..repeat();
      
      // Contrôleur secondaire pour variation et profondeur
      _secondaryController = AnimationController(
        duration: const Duration(seconds: 18),
        vsync: this,
      )..repeat();
      
      // Contrôleur pour le dégradé animé subtil
      _gradientController = AnimationController(
        duration: const Duration(seconds: 20),
        vsync: this,
      )..repeat();
    } else {
      _primaryController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
      _secondaryController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
      _gradientController = AnimationController(
        duration: const Duration(seconds: 1),
        vsync: this,
      );
    }
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Dégradé d'arrière-plan animé très subtil
        AnimatedBuilder(
          animation: _gradientController,
          builder: (context, child) {
            final t = _gradientController.value;
            return Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(
                    -0.3 + 0.1 * math.sin(t * 2 * math.pi),
                    -0.5 + 0.1 * math.cos(t * 1.5 * math.pi),
                  ),
                  radius: 1.5,
                  colors: [
                    const Color(0xFFF8FAFE),
                    const Color(0xFFE3F2FD).withValues(alpha: 0.15 + 0.05 * math.sin(t * 2 * math.pi)),
                    const Color(0xFFFFFFFF),
                    const Color(0xFFF5F5F5),
                  ],
                  stops: const [0.0, 0.3, 0.7, 1.0],
                ),
              ),
            );
          },
        ),
        
        // Formes organiques avec effet de halo
        AnimatedBuilder(
          animation: Listenable.merge([_primaryController, _secondaryController]),
          builder: (context, child) {
            return CustomPaint(
              size: Size.infinite,
              painter: OrganicShapesPainter(
                primaryAnimation: _primaryController.value,
                secondaryAnimation: _secondaryController.value,
                intensity: widget.intensity,
              ),
            );
          },
        ),
        
        // Contenu par-dessus l'animation
        widget.child,
      ],
    );
  }
}

class OrganicShapesPainter extends CustomPainter {
  final double primaryAnimation;
  final double secondaryAnimation;
  final BackgroundIntensity intensity;

  OrganicShapesPainter({
    required this.primaryAnimation,
    required this.secondaryAnimation,
    required this.intensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    _drawOrganicShapes(canvas, size);
  }

  void _drawOrganicShapes(Canvas canvas, Size size) {
    // Ajuster l'opacité et la taille selon l'intensité
    final intensityMultiplier = _getIntensityMultiplier();
    final opacityMultiplier = _getOpacityMultiplier();
    
    final shapes = [
      // Grande forme organique en haut à droite
      {
        'center': Offset(size.width * 0.85, size.height * 0.15),
        'baseRadius': size.width * 0.25 * intensityMultiplier,
        'color': const Color(0xFF4285F4).withValues(alpha: 0.04 * opacityMultiplier),
        'haloColor': const Color(0xFF4285F4).withValues(alpha: 0.02 * opacityMultiplier),
        'phase': 0.0,
        'speed': 1.0,
      },
      // Forme moyenne à gauche
      {
        'center': Offset(size.width * 0.1, size.height * 0.4),
        'baseRadius': size.width * 0.18 * intensityMultiplier,
        'color': const Color(0xFF42A5F5).withValues(alpha: 0.05 * opacityMultiplier),
        'haloColor': const Color(0xFF42A5F5).withValues(alpha: 0.025 * opacityMultiplier),
        'phase': math.pi / 3,
        'speed': 0.8,
      },
      // Forme organique en bas
      {
        'center': Offset(size.width * 0.7, size.height * 0.8),
        'baseRadius': size.width * 0.2 * intensityMultiplier,
        'color': const Color(0xFFE3F2FD).withValues(alpha: 0.08 * opacityMultiplier),
        'haloColor': const Color(0xFFE3F2FD).withValues(alpha: 0.04 * opacityMultiplier),
        'phase': math.pi / 2,
        'speed': 1.2,
      },
      // Petite forme subtile au milieu
      {
        'center': Offset(size.width * 0.4, size.height * 0.6),
        'baseRadius': size.width * 0.12 * intensityMultiplier,
        'color': const Color(0xFFF0F8FF).withValues(alpha: 0.1 * opacityMultiplier),
        'haloColor': const Color(0xFFF0F8FF).withValues(alpha: 0.05 * opacityMultiplier),
        'phase': math.pi,
        'speed': 0.6,
      },
    ];

    for (final shape in shapes) {
      _drawOrganicShape(canvas, size, shape);
    }
  }

  double _getIntensityMultiplier() {
    switch (intensity) {
      case BackgroundIntensity.subtle:
        return 0.6; // Formes plus petites
      case BackgroundIntensity.normal:
        return 1.0; // Taille normale
      case BackgroundIntensity.dynamic:
        return 1.3; // Formes plus grandes
    }
  }

  double _getOpacityMultiplier() {
    switch (intensity) {
      case BackgroundIntensity.subtle:
        return 0.4; // Très discret
      case BackgroundIntensity.normal:
        return 1.0; // Opacité normale
      case BackgroundIntensity.dynamic:
        return 1.5; // Plus visible
    }
  }

  void _drawOrganicShape(Canvas canvas, Size size, Map<String, dynamic> shapeData) {
    final center = shapeData['center'] as Offset;
    final baseRadius = shapeData['baseRadius'] as double;
    final color = shapeData['color'] as Color;
    final haloColor = shapeData['haloColor'] as Color;
    final phase = shapeData['phase'] as double;
    final speed = shapeData['speed'] as double;

    // Animation des formes avec mouvement organique
    final t1 = primaryAnimation * speed + phase;
    final t2 = secondaryAnimation * speed * 0.7 + phase;

    // Position animée
    final animatedCenter = Offset(
      center.dx + baseRadius * 0.1 * math.sin(t1 * 2 * math.pi),
      center.dy + baseRadius * 0.08 * math.cos(t1 * 1.5 * math.pi),
    );

    // Création du chemin organique
    final path = _createOrganicPath(animatedCenter, baseRadius, t1, t2);

    // Effet de halo (plus grand et plus subtil)
    final haloPaint = Paint()
      ..color = haloColor
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    final haloPath = _createOrganicPath(animatedCenter, baseRadius * 1.3, t1, t2);
    canvas.drawPath(haloPath, haloPaint);

    // Forme principale
    final mainPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    canvas.drawPath(path, mainPaint);
  }

  Path _createOrganicPath(Offset center, double radius, double t1, double t2) {
    final path = Path();
    const numPoints = 12;
    
    for (int i = 0; i < numPoints; i++) {
      final angle = (i / numPoints) * 2 * math.pi;
      
      // Variation organique du rayon
      final radiusVariation = 0.7 + 0.3 * math.sin(angle * 3 + t1 * 2 * math.pi) +
                             0.15 * math.cos(angle * 5 + t2 * 2 * math.pi);
      
      final effectiveRadius = radius * radiusVariation;
      
      final x = center.dx + effectiveRadius * math.cos(angle);
      final y = center.dy + effectiveRadius * math.sin(angle);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Courbes de Bézier pour des transitions fluides
        final prevAngle = ((i - 1) / numPoints) * 2 * math.pi;
        final prevRadiusVar = 0.7 + 0.3 * math.sin(prevAngle * 3 + t1 * 2 * math.pi) +
                             0.15 * math.cos(prevAngle * 5 + t2 * 2 * math.pi);
        final prevRadius = radius * prevRadiusVar;
        
        final prevX = center.dx + prevRadius * math.cos(prevAngle);
        final prevY = center.dy + prevRadius * math.sin(prevAngle);
        
        final cp1X = prevX + (effectiveRadius * 0.2) * math.cos(prevAngle + math.pi/2);
        final cp1Y = prevY + (effectiveRadius * 0.2) * math.sin(prevAngle + math.pi/2);
        final cp2X = x - (effectiveRadius * 0.2) * math.cos(angle + math.pi/2);
        final cp2Y = y - (effectiveRadius * 0.2) * math.sin(angle + math.pi/2);
        
        path.cubicTo(cp1X, cp1Y, cp2X, cp2Y, x, y);
      }
    }
    
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(OrganicShapesPainter oldDelegate) {
    return oldDelegate.primaryAnimation != primaryAnimation ||
           oldDelegate.secondaryAnimation != secondaryAnimation;
  }
}