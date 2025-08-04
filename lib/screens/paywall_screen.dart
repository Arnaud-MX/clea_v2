import 'package:flutter/material.dart';
import 'package:clea/models/user_profile.dart';
import 'package:clea/widgets/custom_button.dart';
import 'package:clea/widgets/custom_card.dart';
import 'package:clea/screens/simulation_screen.dart';
import 'package:clea/utils/responsive_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class PaywallScreen extends StatefulWidget {
  final UserProfile profile;

  const PaywallScreen({super.key, required this.profile});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cléa Premium'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: ResponsiveContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(theme),
                SizedBox(height: context.getSpacing(mobile: 32, tablet: 40, desktop: 48)),
                _buildPremiumCard(theme),
                SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
                _buildFeatures(theme),
                SizedBox(height: context.getSpacing(mobile: 32, tablet: 40, desktop: 48)),
                _buildPricing(theme),
                SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
                _buildCTA(context, theme),
                SizedBox(height: context.getSpacing(mobile: 48, tablet: 56, desktop: 64)),
                _buildInvestmentSection(theme),
                SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.diamond,
                color: Colors.black87,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Premium',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFFD700),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Optimise ton patrimoine avec des outils avancés',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            height: 1.2,
            fontSize: context.getAdaptiveFontSize(24, tabletMultiplier: 1.2, desktopMultiplier: 1.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Accède à des simulations personnalisées et des conseils IA pour maximiser ton potentiel financier.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            height: 1.4,
            fontSize: context.getAdaptiveFontSize(16, tabletMultiplier: 1.1, desktopMultiplier: 1.2),
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumCard(ThemeData theme) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFFFD700).withValues(alpha: 0.1),
              const Color(0xFFFFA000).withValues(alpha: 0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFFFD700).withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: CustomCard(
          backgroundColor: Colors.transparent,
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_graph,
                    size: 32,
                    color: Color(0xFFFFD700),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Simulation personnalisée',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFFD700),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://ibb.co/Lzkvjt3b',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.trending_up,
                        size: 40,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatures(ThemeData theme) {
    final features = [
      {
        'icon': Icons.timeline,
        'title': 'Simulation d\'évolution patrimoniale',
        'description': 'Projette ton patrimoine sur 1 à 30 ans avec différentes stratégies d\'épargne',
      },
      {
        'icon': Icons.psychology,
        'title': 'Fiche de conseils IA personnalisée',
        'description': 'Reçois des recommandations générées par GPT-4 adaptées à ta situation',
      },
      {
        'icon': Icons.insights,
        'title': 'Stratégies d\'investissement par profil',
        'description': 'Découvre les meilleures options selon ton âge, revenus et objectifs',
      },
      {
        'icon': Icons.compare_arrows,
        'title': 'Comparaison de scénarios',
        'description': 'Compare différents types d\'investissements : Livret A, ETF, immobilier...',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ce que tu obtiens avec Premium :',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: context.getAdaptiveFontSize(22, tabletMultiplier: 1.1, desktopMultiplier: 1.2),
          ),
        ),
        SizedBox(height: context.getSpacing(mobile: 20, tablet: 24, desktop: 28)),
        if (context.isDesktop)
          _buildFeaturesGrid(features, theme)
        else
          _buildFeaturesList(features, theme),
      ],
    );
  }

  Widget _buildFeaturesGrid(List<Map<String, dynamic>> features, ThemeData theme) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 20,
        childAspectRatio: 3.5,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return _buildFeatureItem(feature, theme);
      },
    );
  }

  Widget _buildFeaturesList(List<Map<String, dynamic>> features, ThemeData theme) {
    return Column(
      children: features.map((feature) => Container(
        margin: EdgeInsets.only(bottom: context.getSpacing(mobile: 16, tablet: 20, desktop: 24)),
        child: _buildFeatureItem(feature, theme),
      )).toList(),
    );
  }

  Widget _buildFeatureItem(Map<String, dynamic> feature, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(context.isDesktop ? 12 : 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            feature['icon'] as IconData,
            size: context.isDesktop ? 24 : 20,
            color: theme.colorScheme.primary,
          ),
        ),
        SizedBox(width: context.getSpacing(mobile: 16, tablet: 20, desktop: 24)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feature['title'] as String,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: context.getAdaptiveFontSize(16, tabletMultiplier: 1.1, desktopMultiplier: 1.2),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                feature['description'] as String,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.4,
                  fontSize: context.getAdaptiveFontSize(14, tabletMultiplier: 1.05, desktopMultiplier: 1.1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPricing(ThemeData theme) {
    return CustomCard(
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '3,99€',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'ACHAT UNIQUE',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF4CAF50),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Accès à vie • Sans abonnement • Paiement sécurisé',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security,
                size: 16,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 4),
              Text(
                'Paiement sécurisé par Stripe',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTA(BuildContext context, ThemeData theme) {
    return Column(
      children: [
        CustomButton(
          text: 'Débloquer Premium - 3,99€',
          icon: Icons.diamond,
          type: ButtonType.premium,
          width: double.infinity,
          onPressed: () {
            _simulatePayment(context);
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Tu peux annuler à tout moment. Garantie satisfait ou remboursé 7 jours.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInvestmentSection(ThemeData theme) {
    final investmentPlatforms = [
      {
        'icon': '🏦',
        'title': 'Boursorama Banque',
        'subtitle': 'Banque en ligne + courtage',
        'url': 'https://www.boursorama.com', // Remplacer par le lien de parrainage
      },
      {
        'icon': '📈',
        'title': 'Trade Republic',
        'subtitle': 'Investir en actions/ETF',
        'url': 'https://traderepublic.com', // Remplacer par le lien de parrainage
      },
      {
        'icon': '🤖',
        'title': 'Yomoni',
        'subtitle': 'Gestion pilotée simple',
        'url': 'https://www.yomoni.fr', // Remplacer par le lien de parrainage
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Commencez à investir dès aujourd\'hui',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2A73FF),
            fontSize: context.getAdaptiveFontSize(24, tabletMultiplier: 1.2, desktopMultiplier: 1.4),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.getSpacing(mobile: 8, tablet: 12, desktop: 16)),
        Text(
          'Découvrez des plateformes simples et fiables pour démarrer vos investissements.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            height: 1.4,
            fontSize: context.getAdaptiveFontSize(16, tabletMultiplier: 1.1, desktopMultiplier: 1.2),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
        if (context.isDesktop)
          _buildInvestmentCardsGrid(investmentPlatforms, theme)
        else
          _buildInvestmentCardsColumn(investmentPlatforms, theme),
        SizedBox(height: context.getSpacing(mobile: 16, tablet: 20, desktop: 24)),
        Text(
          'Lien de parrainage, sans frais pour vous.',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            fontStyle: FontStyle.italic,
            fontSize: context.getAdaptiveFontSize(12, tabletMultiplier: 1.05, desktopMultiplier: 1.1),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInvestmentCardsGrid(List<Map<String, String>> platforms, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: platforms.map((platform) => Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: context.getSpacing(mobile: 6, tablet: 8, desktop: 12)),
          child: _buildInvestmentCard(platform, theme),
        ),
      )).toList(),
    );
  }

  Widget _buildInvestmentCardsColumn(List<Map<String, String>> platforms, ThemeData theme) {
    return Column(
      children: platforms
          .map((platform) => Container(
                constraints: BoxConstraints(maxWidth: context.isTablet ? 600 : 480),
                margin: EdgeInsets.only(bottom: context.getSpacing(mobile: 12, tablet: 16, desktop: 20)),
                child: _buildInvestmentCard(platform, theme),
              ))
          .toList(),
    );
  }

  Widget _buildInvestmentCard(Map<String, String> platform, ThemeData theme) {
    final cardPadding = context.getSpacing(mobile: 20, tablet: 24, desktop: 28);
    final iconSize = context.getAdaptiveFontSize(36, tabletMultiplier: 1.1, desktopMultiplier: 1.2);
    
    return GestureDetector(
      onTap: () => _launchURL(platform['url']!),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(cardPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              offset: const Offset(0, 4),
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              platform['icon']!,
              style: TextStyle(fontSize: iconSize),
            ),
            SizedBox(height: context.getSpacing(mobile: 16, tablet: 18, desktop: 20)),
            Text(
              platform['title']!,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2A73FF),
                fontSize: context.getAdaptiveFontSize(22, tabletMultiplier: 1.1, desktopMultiplier: 1.2),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: context.getSpacing(mobile: 6, tablet: 8, desktop: 10)),
            Text(
              platform['subtitle']!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: context.getAdaptiveFontSize(14, tabletMultiplier: 1.05, desktopMultiplier: 1.1),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      // Handle error - could show a snackbar or dialog
      debugPrint('Impossible d\'ouvrir le lien: $url');
    }
  }

  void _simulatePayment(BuildContext context) {
    // Simulate payment processing
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Traitement du paiement...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop(); // Close loading dialog
      
      // Show success and navigate to simulation
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.check_circle, color: Color(0xFF4CAF50)),
              const SizedBox(width: 8),
              const Text('Merci !'),
            ],
          ),
          content: const Text('Premium activé avec succès. Profite de toutes les fonctionnalités !'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close success dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SimulationScreen(profile: widget.profile),
                  ),
                );
              },
              child: const Text('Continuer'),
            ),
          ],
        ),
      );
    });
  }
}