import 'package:flutter/material.dart';
import 'package:clea/models/user_profile.dart';
import 'package:clea/services/wealth_calculator.dart';
import 'package:clea/widgets/custom_button.dart';
import 'package:clea/widgets/custom_card.dart';
import 'package:clea/widgets/percentile_chart.dart';
import 'package:clea/widgets/animated_background.dart';
import 'package:clea/screens/paywall_screen.dart';
import 'package:clea/utils/responsive_utils.dart';
import 'dart:math' as math;

class RankingScreen extends StatefulWidget {
  final UserProfile profile;

  const RankingScreen({super.key, required this.profile});

  @override
  State<RankingScreen> createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen>
    with TickerProviderStateMixin {
  late WealthRanking ranking;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    ranking = WealthCalculator.calculateRanking(widget.profile);
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );
    
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ton classement'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: AnimatedBackground(
        intensity: BackgroundIntensity.subtle,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: ResponsiveContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(theme),
                  SizedBox(height: context.getSpacing(mobile: 32, tablet: 40, desktop: 48)),
                  _buildRankingCard(theme),
                  SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
                  _buildPercentileChart(),
                  SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
                  _buildStatsCards(theme),
                  SizedBox(height: context.getSpacing(mobile: 32, tablet: 40, desktop: 48)),
                  _buildUnlockSection(theme),
                  SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
                ],
              ),
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
        ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _getRankingColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getRankingIcon(),
                  size: 20,
                  color: _getRankingColor(),
                ),
                const SizedBox(width: 8),
                Text(
                  'Classement calculé',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: _getRankingColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Voici ton classement',
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: context.getAdaptiveFontSize(32, tabletMultiplier: 1.2, desktopMultiplier: 1.4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          ranking.message,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            height: 1.4,
            fontSize: context.getAdaptiveFontSize(16, tabletMultiplier: 1.1, desktopMultiplier: 1.2),
          ),
        ),
      ],
    );
  }

  Widget _buildRankingCard(ThemeData theme) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: CustomCard(
        backgroundColor: _getRankingColor().withValues(alpha: 0.05),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getRankingColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.emoji_events,
                    size: 32,
                    color: _getRankingColor(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tu es dans le',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        'TOP ${(100 - ranking.percentile).round()}%',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getRankingColor(),
                        ),
                      ),
                      Text(
                        'des Français de ${widget.profile.age} ans',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ton patrimoine net',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  Text(
                    '${_formatCurrency(widget.profile.netWorth)}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getRankingColor(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentileChart() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ta position par rapport aux Français de ton âge',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          PercentileChart(percentile: ranking.percentile),
        ],
      ),
    );
  }

  Widget _buildStatsCards(ThemeData theme) {
    final spacing = context.getSpacing(mobile: 12, tablet: 16, desktop: 20);
    
    return Column(
      children: [
        if (context.isDesktop)
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Médiane ${widget.profile.age} ans',
                  value: _formatCurrency(ranking.medianForAge),
                  icon: Icons.group,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: StatCard(
                  title: 'Moyenne nationale',
                  value: _formatCurrency(ranking.nationalAverage),
                  icon: Icons.public,
                  color: theme.colorScheme.secondary,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: StatCard(
                  title: 'Ton avantage',
                  value: ranking.isAboveAverage
                      ? '+${_formatCurrency(widget.profile.netWorth - ranking.medianForAge)}'
                      : '${_formatCurrency(widget.profile.netWorth - ranking.medianForAge)}',
                  subtitle: ranking.isAboveAverage
                      ? 'Au-dessus de la médiane de ton âge'
                      : 'En-dessous de la médiane de ton âge',
                  icon: ranking.isAboveAverage ? Icons.trending_up : Icons.trending_down,
                  color: ranking.isAboveAverage
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFFFF9800),
                ),
              ),
            ],
          )
        else
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Médiane ${widget.profile.age} ans',
                      value: _formatCurrency(ranking.medianForAge),
                      icon: Icons.group,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  SizedBox(width: spacing),
                  Expanded(
                    child: StatCard(
                      title: 'Moyenne nationale',
                      value: _formatCurrency(ranking.nationalAverage),
                      icon: Icons.public,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),
              StatCard(
                title: 'Ton avantage',
                value: ranking.isAboveAverage
                    ? '+${_formatCurrency(widget.profile.netWorth - ranking.medianForAge)}'
                    : '${_formatCurrency(widget.profile.netWorth - ranking.medianForAge)}',
                subtitle: ranking.isAboveAverage
                    ? 'Au-dessus de la médiane de ton âge'
                    : 'En-dessous de la médiane de ton âge',
                icon: ranking.isAboveAverage ? Icons.trending_up : Icons.trending_down,
                color: ranking.isAboveAverage
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFFFF9800),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildUnlockSection(ThemeData theme) {
    return CustomCard(
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lock,
                color: theme.colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'En savoir plus',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Découvre comment améliorer ton classement avec :',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 12),
          ...const [
            '📈 Simulation d\'évolution patrimoniale personnalisée',
            '🤖 Conseils IA adaptés à ta situation',
            '💡 Stratégies d\'investissement par profil',
          ].map((text) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          )).toList(),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Débloquer Premium',
            icon: Icons.diamond,
            type: ButtonType.premium,
            width: double.infinity,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaywallScreen(profile: widget.profile),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getRankingColor() {
    if (ranking.percentile >= 90) return const Color(0xFF4CAF50);
    if (ranking.percentile >= 75) return const Color(0xFF66BB6A);
    if (ranking.percentile >= 50) return const Color(0xFFFFC107);
    if (ranking.percentile >= 25) return const Color(0xFFFF9800);
    return const Color(0xFFEF5350);
  }

  IconData _getRankingIcon() {
    if (ranking.percentile >= 90) return Icons.military_tech;
    if (ranking.percentile >= 75) return Icons.emoji_events;
    if (ranking.percentile >= 50) return Icons.thumb_up;
    return Icons.trending_up;
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M€';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(0)}k€';
    } else {
      return '${amount.toStringAsFixed(0)}€';
    }
  }
}