import 'package:flutter/material.dart';
import 'package:clea/theme.dart';

/// Widget d'icône de l'application Cléa - optimisé pour l'écran d'accueil mobile
class CleaLogo extends StatelessWidget {
  final double size;
  final bool isRounded;
  final bool showShadow;
  
  const CleaLogo({
    super.key,
    this.size = 80,
    this.isRounded = true,
    this.showShadow = true,
  });
  
  /// Version carrée aux coins très arrondis
  const CleaLogo.square({
    super.key,
    this.size = 80,
    this.showShadow = true,
  }) : isRounded = false;
  
  /// Version ronde
  const CleaLogo.round({
    super.key,
    this.size = 80,
    this.showShadow = true,
  }) : isRounded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: isRounded 
          ? BorderRadius.circular(size / 2) 
          : BorderRadius.circular(size * 0.2),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            LightModeColors.cleaBlueStart, // #2A73FF
            LightModeColors.cleaBlueEnd,   // #6FCBFF
          ],
          stops: [0.0, 1.0],
        ),
        boxShadow: showShadow ? [
          BoxShadow(
            color: LightModeColors.cleaBlueStart.withValues(alpha: 0.3),
            blurRadius: size * 0.2,
            offset: Offset(0, size * 0.08),
            spreadRadius: 0,
          ),
        ] : null,
      ),
      child: Center(
        child: Icon(
          Icons.vpn_key_rounded,
          size: size * 0.5,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// Widget complet avec logo et nom de l'application
class CleaAppLogo extends StatelessWidget {
  final double logoSize;
  final double? textSize;
  final bool isRounded;
  final bool showShadow;
  final MainAxisAlignment alignment;
  final CrossAxisAlignment crossAlignment;
  final double spacing;
  
  const CleaAppLogo({
    super.key,
    this.logoSize = 100,
    this.textSize,
    this.isRounded = true,
    this.showShadow = true,
    this.alignment = MainAxisAlignment.center,
    this.crossAlignment = CrossAxisAlignment.center,
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      mainAxisAlignment: alignment,
      crossAxisAlignment: crossAlignment,
      mainAxisSize: MainAxisSize.min,
      children: [
        CleaLogo(
          size: logoSize,
          isRounded: isRounded,
          showShadow: showShadow,
        ),
        SizedBox(height: spacing),
        Text(
          'Cléa',
          style: theme.textTheme.displaySmall?.copyWith(
            color: LightModeColors.cleaTextBlue,
            fontWeight: FontWeight.w600,
            fontSize: textSize ?? theme.textTheme.displaySmall?.fontSize,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}