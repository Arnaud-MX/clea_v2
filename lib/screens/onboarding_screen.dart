import 'package:flutter/material.dart';
import 'package:clea/widgets/custom_button.dart';
import 'package:clea/widgets/custom_card.dart';
import 'package:clea/widgets/animated_background.dart';
import 'package:clea/widgets/app_welcome_logo.dart';
import 'package:clea/screens/user_form_screen.dart';
import 'package:clea/utils/responsive_utils.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      body: AnimatedBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.getSpacing(mobile: 40, tablet: 48, desktop: 56)),
                  _buildHeader(context, theme),
                  SizedBox(height: context.getSpacing(mobile: 40, tablet: 48, desktop: 56)),
                  _buildHeroImage(context),
                  SizedBox(height: context.getSpacing(mobile: 40, tablet: 48, desktop: 56)),
                  _buildFeatures(context),
                  SizedBox(height: context.getSpacing(mobile: 40, tablet: 48, desktop: 56)),
                  _buildCTA(context),
                  SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AppWelcomeLogo(
          size: 100,
          showAppName: true,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        const SizedBox(height: 16),
        Text(
          'Découvre ton rang patrimonial en 2 minutes',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
            height: 1.2,
            fontSize: context.getAdaptiveFontSize(24, tabletMultiplier: 1.2, desktopMultiplier: 1.4),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Compare ta situation financière à celle des Français de ton âge et reçois des conseils pour l\'optimiser.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            height: 1.5,
            fontSize: context.getAdaptiveFontSize(16, tabletMultiplier: 1.1, desktopMultiplier: 1.2),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(BuildContext context) {
    final imageHeight = context.getAdaptiveFontSize(200, tabletMultiplier: 1.2, desktopMultiplier: 1.4);
    final iconSize = context.getAdaptiveFontSize(80, tabletMultiplier: 1.2, desktopMultiplier: 1.4);
    
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          'https://ibb.co/Lzkvjt3b',
          height: imageHeight,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: imageHeight,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.savings,
                size: iconSize,
                color: Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    final features = [
      {
        'icon': Icons.leaderboard,
        'title': 'Classement patrimonial',
        'description': 'Découvre où tu te situes par rapport aux Français de ton âge',
      },
      {
        'icon': Icons.trending_up,
        'title': 'Simulation d\'épargne',
        'description': 'Projette l\'évolution de ton patrimoine avec différentes stratégies',
      },
      {
        'icon': Icons.psychology,
        'title': 'Conseils personnalisés',
        'description': 'Reçois une fiche-conseil IA adaptée à ta situation',
      },
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ce que tu vas découvrir :',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: context.getAdaptiveFontSize(22, tabletMultiplier: 1.1, desktopMultiplier: 1.2),
          ),
        ),
        SizedBox(height: context.getSpacing(mobile: 20, tablet: 24, desktop: 28)),
        if (context.isDesktop)
          _buildFeaturesGrid(features)
        else
          _buildFeaturesList(features),
      ],
    );
  }
  
  Widget _buildFeaturesGrid(List<Map<String, dynamic>> features) {
    return Builder(
      builder: (context) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: features.map((feature) => Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: context.getSpacing(mobile: 8, tablet: 12, desktop: 16) / 2),
              child: FeatureCard(
                icon: feature['icon'] as IconData,
                title: feature['title'] as String,
                description: feature['description'] as String,
              ),
            ),
          )).toList(),
        );
      },
    );
  }
  
  Widget _buildFeaturesList(List<Map<String, dynamic>> features) {
    return Builder(
      builder: (context) {
        return Column(
          children: features.map((feature) => Container(
            margin: EdgeInsets.only(bottom: context.getSpacing(mobile: 16, tablet: 20, desktop: 24)),
            child: FeatureCard(
              icon: feature['icon'] as IconData,
              title: feature['title'] as String,
              description: feature['description'] as String,
            ),
          )).toList(),
        );
      },
    );
  }

  Widget _buildCTA(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'Commencer',
          icon: Icons.arrow_forward,
          width: double.infinity,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserFormScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer,
              size: 16,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            const SizedBox(width: 4),
            Text(
              '2 minutes • Gratuit • Anonyme',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }
}