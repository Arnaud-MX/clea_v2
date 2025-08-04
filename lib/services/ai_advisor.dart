import 'dart:math';
import 'package:clea/models/user_profile.dart';

class AIAdvisor {
  static Future<AIAdvice> generateAdvice(UserProfile profile, WealthRanking ranking, InvestmentSimulation? simulation) async {
    // Simulate AI processing delay
    await Future.delayed(const Duration(seconds: 2));
    
    final recommendations = <String>[];
    String title = 'Ton plan financier personnalisé';
    String content = '';
    
    // Age-based advice
    if (profile.age < 30) {
      content += 'À ${profile.age} ans, tu as un avantage majeur : le temps ! ';
      recommendations.add('Commence à investir dès maintenant, même avec de petites sommes');
      recommendations.add('Privilégie les investissements à long terme comme les ETF');
    } else if (profile.age < 40) {
      content += 'La trentaine est le moment idéal pour accélérer ton épargne. ';
      recommendations.add('Augmente progressivement ton taux d\'épargne');
      recommendations.add('Diversifie tes investissements entre sécurité et performance');
    } else if (profile.age < 50) {
      content += 'Approchant de la cinquantaine, il est temps d\'optimiser ton patrimoine. ';
      recommendations.add('Équilibre entre croissance et préservation du capital');
      recommendations.add('Pense à préparer ta retraite activement');
    } else {
      content += 'Proche de la retraite, la préservation de ton patrimoine devient prioritaire. ';
      recommendations.add('Privilégie les investissements sécurisés');
      recommendations.add('Optimise la fiscalité de tes revenus futurs');
    }
    
    // Wealth-based advice
    if (ranking.percentile < 25) {
      content += 'Ton patrimoine actuel peut sembler modeste, mais chaque euro compte ! ';
      recommendations.add('Commence par constituer une épargne de précaution (3-6 mois de charges)');
      recommendations.add('Automatise ton épargne avec un virement mensuel');
      recommendations.add('Évite les dettes coûteuses (crédit consommation, découvert)');
    } else if (ranking.percentile < 50) {
      content += 'Tu es sur la bonne voie avec un patrimoine correct pour ton âge. ';
      recommendations.add('Augmente ton taux d\'épargne de 2-3% de tes revenus');
      recommendations.add('Explore l\'assurance-vie pour optimiser la fiscalité');
      recommendations.add('Commence à investir une partie en actions via des ETF');
    } else if (ranking.percentile < 75) {
      content += 'Félicitations ! Ton patrimoine est au-dessus de la moyenne. ';
      recommendations.add('Diversifie tes investissements géographiquement');
      recommendations.add('Pense à l\'immobilier locatif si tu n\'en as pas');
      recommendations.add('Optimise ta fiscalité avec des dispositifs adaptés');
    } else {
      content += 'Excellent ! Tu fais partie des épargnants les plus aisés. ';
      recommendations.add('Consulte un conseiller en gestion de patrimoine');
      recommendations.add('Explore les investissements alternatifs (SCPI, private equity)');
      recommendations.add('Pense à la transmission de ton patrimoine');
    }
    
    // Income-based advice
    final savingsRate = profile.netWorth / (profile.monthlyIncome * 12);
    if (savingsRate < 0.5) {
      recommendations.add('Augmente ton taux d\'épargne : vise 15-20% de tes revenus');
    } else if (savingsRate < 2) {
      recommendations.add('Bon taux d\'épargne ! Maintiens cet effort sur le long terme');
    } else {
      recommendations.add('Excellent taux d\'épargne ! Optimise maintenant tes placements');
    }
    
    // Family status advice
    switch (profile.familyStatus) {
      case FamilyStatus.single:
        recommendations.add('Profite de ta flexibilité pour prendre plus de risques');
        break;
      case FamilyStatus.couple:
        recommendations.add('Coordonne vos stratégies d\'épargne et d\'investissement');
        break;
      case FamilyStatus.coupleWithChildren:
        recommendations.add('Pense à souscrire une assurance-vie pour protéger ta famille');
        recommendations.add('Commence à épargner pour les études de tes enfants');
        break;
      case FamilyStatus.singleParent:
        recommendations.add('Priorise la sécurité financière et l\'épargne de précaution');
        break;
    }
    
    // Add simulation-based advice if available
    if (simulation != null) {
      content += '\nAvec ton projet d\'épargne de ${simulation.monthlyAmount.toInt()}€/mois sur ${simulation.years} ans, ';
      if (simulation.finalPercentile > ranking.percentile + 10) {
        content += 'tu pourrais considérablement améliorer ton classement ! ';
        recommendations.add('Lance-toi dans ce plan d\'épargne ambitieux');
      } else {
        content += 'tu maintiendrais ta position patrimoniale. ';
        recommendations.add('Considère augmenter le montant mensuel si possible');
      }
    }
    
    return AIAdvice(
      title: title,
      content: content,
      recommendations: recommendations.take(6).toList(), // Limit to 6 recommendations
      generatedAt: DateTime.now(),
    );
  }
  
  static List<String> getQuickTips(WealthRanking ranking) {
    final tips = <String>[];
    
    if (ranking.percentile < 50) {
      tips.addAll([
        '💡 Automatise ton épargne avec un virement mensuel',
        '📱 Utilise des apps de micro-épargne pour arrondir tes achats',
        '🏦 Ouvre une assurance-vie pour défiscaliser',
        '📊 Commence par un ETF monde pour débuter en bourse',
      ]);
    } else {
      tips.addAll([
        '🏠 Pense à l\'immobilier locatif pour diversifier',
        '🌍 Investis dans des ETF internationaux',
        '💼 Explore les SCPI pour de l\'immobilier sans contraintes',
        '📈 Augmente progressivement ta prise de risque',
      ]);
    }
    
    return tips;
  }
}