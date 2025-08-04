import 'package:flutter/material.dart';

/// Utility class pour gérer les breakpoints responsives
class ResponsiveUtils {
  // Breakpoints
  static const double mobileBreakpoint = 0;
  static const double tabletBreakpoint = 768;
  static const double desktopBreakpoint = 1024;
  
  // Largeurs maximales recommandées
  static const double maxContentWidth = 960;
  static const double maxMobileContentWidth = 480;
  
  /// Retourne true si l'écran est en mode mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletBreakpoint;
  }
  
  /// Retourne true si l'écran est en mode tablette
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= tabletBreakpoint && width < desktopBreakpoint;
  }
  
  /// Retourne true si l'écran est en mode desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }
  
  /// Retourne le nombre de colonnes optimal selon la taille d'écran
  static int getOptimalColumns(BuildContext context, {int maxColumns = 3}) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return maxColumns >= 2 ? 2 : 1;
    return maxColumns;
  }
  
  /// Retourne l'espacement optimal selon la taille d'écran
  static double getSpacing(BuildContext context, {
    double mobile = 16,
    double tablet = 24,
    double desktop = 32,
  }) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
  
  /// Retourne le padding optimal selon la taille d'écran
  static EdgeInsets getPadding(BuildContext context, {
    EdgeInsets? mobile,
    EdgeInsets? tablet,
    EdgeInsets? desktop,
  }) {
    mobile ??= const EdgeInsets.all(16);
    tablet ??= const EdgeInsets.all(24);
    desktop ??= const EdgeInsets.all(32);
    
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
  
  /// Retourne la largeur maximale du contenu selon la taille d'écran
  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) return maxMobileContentWidth;
    return maxContentWidth;
  }
  
  /// Retourne la taille de police adaptée selon la taille d'écran
  static double getAdaptiveFontSize(BuildContext context, {
    required double baseFontSize,
    double tabletMultiplier = 1.1,
    double desktopMultiplier = 1.2,
  }) {
    if (isDesktop(context)) return baseFontSize * desktopMultiplier;
    if (isTablet(context)) return baseFontSize * tabletMultiplier;
    return baseFontSize;
  }
}

/// Widget responsif qui centre le contenu et applique une largeur maximale
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final double? maxWidth;
  final EdgeInsets? padding;
  final bool applyHorizontalPadding;
  
  const ResponsiveContainer({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.applyHorizontalPadding = true,
  });
  
  @override
  Widget build(BuildContext context) {
    final effectiveMaxWidth = maxWidth ?? ResponsiveUtils.getMaxContentWidth(context);
    final effectivePadding = padding ?? ResponsiveUtils.getPadding(context);
    
    Widget content = Container(
      constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
      child: child,
    );
    
    if (applyHorizontalPadding) {
      content = Padding(
        padding: effectivePadding,
        child: content,
      );
    }
    
    return Center(
      child: content,
    );
  }
}

/// Grid adaptif qui ajuste automatiquement le nombre de colonnes
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final int maxColumns;
  final double spacing;
  final double runSpacing;
  final EdgeInsets? padding;
  
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.maxColumns = 3,
    this.spacing = 16,
    this.runSpacing = 16,
    this.padding,
  });
  
  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveUtils.getOptimalColumns(context, maxColumns: maxColumns);
    final adaptiveSpacing = ResponsiveUtils.getSpacing(context, 
      mobile: spacing, 
      tablet: spacing * 1.5, 
      desktop: spacing * 2
    );
    
    if (columns == 1) {
      return Column(
        children: children.map((child) => Container(
          margin: EdgeInsets.only(bottom: adaptiveSpacing),
          child: child,
        )).toList(),
      );
    }
    
    return Wrap(
      spacing: adaptiveSpacing,
      runSpacing: runSpacing,
      children: children.map((child) => SizedBox(
        width: (MediaQuery.of(context).size.width - 
               (padding?.horizontal ?? 0) - 
               (adaptiveSpacing * (columns - 1))) / columns,
        child: child,
      )).toList(),
    );
  }
}

/// Extension pour faciliter l'utilisation des breakpoints
extension ResponsiveExtension on BuildContext {
  bool get isMobile => ResponsiveUtils.isMobile(this);
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  
  double getSpacing({double mobile = 16, double tablet = 24, double desktop = 32}) {
    return ResponsiveUtils.getSpacing(this, mobile: mobile, tablet: tablet, desktop: desktop);
  }
  
  EdgeInsets getPadding({EdgeInsets? mobile, EdgeInsets? tablet, EdgeInsets? desktop}) {
    return ResponsiveUtils.getPadding(this, mobile: mobile, tablet: tablet, desktop: desktop);
  }
  
  double getAdaptiveFontSize(double baseFontSize, {double tabletMultiplier = 1.1, double desktopMultiplier = 1.2}) {
    return ResponsiveUtils.getAdaptiveFontSize(this, 
      baseFontSize: baseFontSize, 
      tabletMultiplier: tabletMultiplier, 
      desktopMultiplier: desktopMultiplier
    );
  }
}