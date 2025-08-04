import 'package:flutter/material.dart';
import 'package:clea/theme.dart';

class AppWelcomeLogo extends StatelessWidget {
  final double size;
  final bool showAppName;
  final EdgeInsets padding;
  
  const AppWelcomeLogo({
    super.key,
    this.size = 120,
    this.showAppName = true,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icône de l'application avec dégradé
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  LightModeColors.cleaBlueStart,
                  LightModeColors.cleaBlueEnd,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: LightModeColors.cleaBlueStart.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                Icons.vpn_key_rounded,
                size: size * 0.5,
                color: Colors.white,
              ),
            ),
          ),
          
          if (showAppName) ...[
            const SizedBox(height: 16),
            // Nom de l'application
            Text(
              'Cléa',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: LightModeColors.cleaTextBlue,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class AppWelcomeBackground extends StatelessWidget {
  final Widget child;
  
  const AppWelcomeBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.grey.shade50,
          ],
        ),
      ),
      child: Stack(
        children: [
          // Cercles décoratifs en arrière-plan
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    LightModeColors.cleaBlueEnd.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    LightModeColors.cleaBlueStart.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // Contenu principal
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppWelcomeBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                
                // Logo et nom de l'app
                const AppWelcomeLogo(
                  size: 140,
                  showAppName: true,
                ),
                
                const SizedBox(height: 40),
                
                // Titre principal
                Text(
                  'Découvre ton rang patrimonial en 2 minutes',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.grey.shade800,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Sous-titre
                Text(
                  'Compare ta situation financière à celle des Français de ton âge et reçois des conseils pour l\'optimiser.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                
                const SizedBox(height: 60),
                
                // Boutons d'action
                Column(
                  children: [
                    _buildFeatureButton(
                      context,
                      icon: Icons.trending_up_rounded,
                      title: 'Classement patrimonial',
                      subtitle: 'Découvre ta position',
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildFeatureButton(
                      context,
                      icon: Icons.savings_rounded,
                      title: 'Simulation d\'épargne',
                      subtitle: 'Projette ton avenir',
                    ),
                    
                    const SizedBox(height: 16),
                    
                    _buildFeatureButton(
                      context,
                      icon: Icons.lightbulb_outline_rounded,
                      title: 'Conseils personnalisés',
                      subtitle: 'Optimise tes finances',
                    ),
                  ],
                ),
                
                const SizedBox(height: 40),
                
                // CTA principal
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/user-form');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: LightModeColors.cleaBlueStart,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Commencer',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureButton(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: LightModeColors.cleaBlueEnd.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: LightModeColors.cleaBlueStart,
              size: 24,
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}