import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clea/models/user_profile.dart';
import 'package:clea/services/wealth_calculator.dart';
import 'package:clea/widgets/custom_button.dart';
import 'package:clea/widgets/custom_card.dart';
import 'package:clea/screens/ai_advice_screen.dart';
import 'package:clea/utils/responsive_utils.dart';
import 'dart:math' as math;

class SimulationScreen extends StatefulWidget {
  final UserProfile profile;

  const SimulationScreen({super.key, required this.profile});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen>
    with TickerProviderStateMixin {
  double _monthlyAmount = 200;
  int _years = 10;
  InvestmentType _investmentType = InvestmentType.etf;
  InvestmentSimulation? _simulation;
  
  late AnimationController _chartController;
  late Animation<double> _chartAnimation;

  @override
  void initState() {
    super.initState();
    _chartController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _chartAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _chartController, curve: Curves.easeOutCubic),
    );
    _calculateSimulation();
  }

  @override
  void dispose() {
    _chartController.dispose();
    super.dispose();
  }

  void _calculateSimulation() {
    setState(() {
      _simulation = WealthCalculator.simulateInvestment(
        currentNetWorth: widget.profile.netWorth,
        monthlyAmount: _monthlyAmount,
        years: _years,
        type: _investmentType,
        currentAge: widget.profile.age,
      );
    });
    _chartController.reset();
    _chartController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simulation d\'épargne'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ResponsiveContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(theme),
              SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
              _buildInputs(theme),
              SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
              if (_simulation != null) ...[
                _buildChart(theme),
                SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
                _buildResults(theme),
                SizedBox(height: context.getSpacing(mobile: 32, tablet: 40, desktop: 48)),
                _buildCTA(context, theme),
              ],
              SizedBox(height: context.getSpacing(mobile: 24, tablet: 32, desktop: 40)),
            ],
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
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.timeline,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'Premium',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: const Color(0xFFFFD700),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'Simule ton évolution patrimoniale',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Découvre comment ton patrimoine pourrait évoluer avec une épargne régulière.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildInputs(ThemeData theme) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Paramètres de simulation',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          
          // Monthly amount
          _buildSliderSection(
            title: 'Épargne mensuelle',
            value: '${_monthlyAmount.toInt()}€',
            child: Slider(
              value: _monthlyAmount,
              min: 50,
              max: 2000,
              divisions: 39,
              onChanged: (value) {
                setState(() {
                  _monthlyAmount = value;
                });
                _calculateSimulation();
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Years
          _buildSliderSection(
            title: 'Durée',
            value: '$_years ans',
            child: Slider(
              value: _years.toDouble(),
              min: 1,
              max: 30,
              divisions: 29,
              onChanged: (value) {
                setState(() {
                  _years = value.toInt();
                });
                _calculateSimulation();
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Investment type
          Text(
            'Type d\'investissement',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: InvestmentType.values.map((type) {
              final isSelected = _investmentType == type;
              return ChoiceChip(
                label: Text(
                  type.displayName,
                  style: TextStyle(
                    color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) {
                  if (selected) {
                    setState(() {
                      _investmentType = type;
                    });
                    _calculateSimulation();
                  }
                },
                selectedColor: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.surface,
                side: BorderSide(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.2),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSliderSection({
    required String title,
    required String value,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        child,
      ],
    );
  }

  Widget _buildChart(ThemeData theme) {
    if (_simulation == null) return const SizedBox.shrink();
    
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Évolution de ton patrimoine',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: AnimatedBuilder(
              animation: _chartAnimation,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(double.infinity, 200),
                  painter: WealthChartPainter(
                    simulation: _simulation!,
                    currentWealth: widget.profile.netWorth,
                    theme: theme,
                    animationValue: _chartAnimation.value,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildLegendItem(theme, 'Patrimoine actuel', theme.colorScheme.onSurface.withValues(alpha: 0.4)),
              const SizedBox(width: 24),
              _buildLegendItem(theme, 'Contributions', theme.colorScheme.secondary),
              const SizedBox(width: 24),
              _buildLegendItem(theme, 'Intérêts', theme.colorScheme.primary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(ThemeData theme, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildResults(ThemeData theme) {
    if (_simulation == null) return const SizedBox.shrink();
    
    final currentRanking = WealthCalculator.calculateRanking(widget.profile);
    final rankingImprovement = _simulation!.finalPercentile - currentRanking.percentile;
    
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: StatCard(
                title: 'Capital final',
                value: _formatCurrency(_simulation!.finalAmount),
                subtitle: '+${_formatCurrency(_simulation!.totalInterest)} d\'intérêts',
                icon: Icons.account_balance_wallet,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                title: 'Nouveau classement',
                value: 'TOP ${(100 - _simulation!.finalPercentile).round()}%',
                subtitle: rankingImprovement > 0 
                    ? '+${rankingImprovement.round()} places'
                    : 'Maintien position',
                icon: Icons.emoji_events,
                color: rankingImprovement > 0 
                    ? const Color(0xFF4CAF50)
                    : theme.colorScheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        StatCard(
          title: 'Rendement annuel moyen',
          value: '${(_investmentType.annualReturn * 100).toStringAsFixed(1)}%',
          subtitle: 'avec ${_investmentType.displayName}',
          icon: Icons.trending_up,
          color: theme.colorScheme.tertiary,
        ),
      ],
    );
  }

  Widget _buildCTA(BuildContext context, ThemeData theme) {
    return CustomCard(
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🎯 Prêt à optimiser ton patrimoine ?',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Découvre des conseils personnalisés pour mettre en œuvre cette stratégie.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: 'Voir mes conseils personnalisés',
            icon: Icons.psychology,
            width: double.infinity,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AIAdviceScreen(
                    profile: widget.profile,
                    simulation: _simulation,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
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

class WealthChartPainter extends CustomPainter {
  final InvestmentSimulation simulation;
  final double currentWealth;
  final ThemeData theme;
  final double animationValue;

  WealthChartPainter({
    required this.simulation,
    required this.currentWealth,
    required this.theme,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final years = simulation.years;
    final stepWidth = size.width / years;
    final maxAmount = simulation.finalAmount;
    
    // Draw bars for each year
    for (int i = 0; i < years; i++) {
      final progress = (i + 1) / years;
      final animatedProgress = math.min(animationValue, progress) / progress;
      if (animatedProgress <= 0) continue;
      
      final yearContributions = simulation.monthlyAmount * 12 * (i + 1);
      final yearAmount = currentWealth + yearContributions * math.pow(1 + simulation.type.annualReturn, i + 1);
      
      final barHeight = (yearAmount / maxAmount) * size.height * animatedProgress;
      final currentHeight = (currentWealth / maxAmount) * size.height * animatedProgress;
      final contributionsHeight = ((yearContributions) / maxAmount) * size.height * animatedProgress;
      
      final x = i * stepWidth;
      final barWidth = stepWidth * 0.8;
      
      // Current wealth (base)
      paint.color = theme.colorScheme.onSurface.withValues(alpha: 0.4);
      canvas.drawRect(
        Rect.fromLTWH(x, size.height - currentHeight, barWidth, currentHeight),
        paint,
      );
      
      // Contributions
      paint.color = theme.colorScheme.secondary;
      canvas.drawRect(
        Rect.fromLTWH(x, size.height - currentHeight - contributionsHeight, barWidth, contributionsHeight),
        paint,
      );
      
      // Interest
      final interestHeight = barHeight - currentHeight - contributionsHeight;
      if (interestHeight > 0) {
        paint.color = theme.colorScheme.primary;
        canvas.drawRect(
          Rect.fromLTWH(x, size.height - barHeight, barWidth, interestHeight),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(WealthChartPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
           oldDelegate.simulation != simulation;
  }
}