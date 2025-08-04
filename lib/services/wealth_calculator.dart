import 'dart:math';
import 'package:clea/models/user_profile.dart';

class WealthCalculator {
  static const Map<int, Map<String, double>> _ageWealthData = {
    25: {'median': 8000, 'p10': 1000, 'p25': 3000, 'p75': 25000, 'p90': 55000},
    30: {'median': 25000, 'p10': 2000, 'p25': 8000, 'p75': 65000, 'p90': 125000},
    35: {'median': 55000, 'p10': 5000, 'p25': 18000, 'p75': 125000, 'p90': 225000},
    40: {'median': 95000, 'p10': 8000, 'p25': 35000, 'p75': 185000, 'p90': 325000},
    45: {'median': 145000, 'p10': 12000, 'p25': 55000, 'p75': 265000, 'p90': 425000},
    50: {'median': 195000, 'p10': 18000, 'p25': 75000, 'p75': 345000, 'p90': 525000},
    55: {'median': 245000, 'p10': 25000, 'p25': 95000, 'p75': 425000, 'p90': 625000},
  };

  static const double _nationalMedian = 113000.0;

  static WealthRanking calculateRanking(UserProfile profile) {
    final ageData = _getDataForAge(profile.age);
    final percentile = _calculatePercentile(profile.netWorth, ageData);
    final medianForAge = ageData['median']!;
    final isAboveAverage = profile.netWorth > medianForAge;
    
    String message;
    if (percentile >= 90) {
      message = 'Félicitations ! Tu fais partie du top 10% des Français de ton âge 🎉';
    } else if (percentile >= 75) {
      message = 'Excellent ! Tu es dans le top 25% des Français de ton âge 👏';
    } else if (percentile >= 50) {
      message = 'Bien joué ! Tu es au-dessus de la médiane de ton âge 👍';
    } else if (percentile >= 25) {
      message = 'Tu es sur la bonne voie ! Encore un petit effort 💪';
    } else {
      message = 'Il y a du potentiel ! Découvre nos conseils pour progresser 🚀';
    }

    return WealthRanking(
      percentile: percentile,
      medianForAge: medianForAge,
      nationalAverage: _nationalMedian,
      message: message,
      isAboveAverage: isAboveAverage,
    );
  }

  static Map<String, double> _getDataForAge(int age) {
    if (age <= 25) return _ageWealthData[25]!;
    if (age <= 30) return _interpolateData(age, 25, 30);
    if (age <= 35) return _interpolateData(age, 30, 35);
    if (age <= 40) return _interpolateData(age, 35, 40);
    if (age <= 45) return _interpolateData(age, 40, 45);
    if (age <= 50) return _interpolateData(age, 45, 50);
    if (age <= 55) return _interpolateData(age, 50, 55);
    return _ageWealthData[55]!;
  }

  static Map<String, double> _interpolateData(int age, int lowerAge, int upperAge) {
    final lowerData = _ageWealthData[lowerAge]!;
    final upperData = _ageWealthData[upperAge]!;
    final ratio = (age - lowerAge) / (upperAge - lowerAge);
    
    return lowerData.map((key, value) => MapEntry(
      key,
      value + (upperData[key]! - value) * ratio,
    ));
  }

  static double _calculatePercentile(double netWorth, Map<String, double> ageData) {
    if (netWorth <= ageData['p10']!) return 10;
    if (netWorth <= ageData['p25']!) return 10 + (netWorth - ageData['p10']!) / (ageData['p25']! - ageData['p10']!) * 15;
    if (netWorth <= ageData['median']!) return 25 + (netWorth - ageData['p25']!) / (ageData['median']! - ageData['p25']!) * 25;
    if (netWorth <= ageData['p75']!) return 50 + (netWorth - ageData['median']!) / (ageData['p75']! - ageData['median']!) * 25;
    if (netWorth <= ageData['p90']!) return 75 + (netWorth - ageData['p75']!) / (ageData['p90']! - ageData['p75']!) * 15;
    
    // For values above p90, we estimate using exponential decay
    final aboveP90 = netWorth - ageData['p90']!;
    final additionalPercentile = 10 * (1 - exp(-aboveP90 / (ageData['p90']! * 0.5)));
    return min(99.9, 90 + additionalPercentile);
  }

  static InvestmentSimulation simulateInvestment({
    required double currentNetWorth,
    required double monthlyAmount,
    required int years,
    required InvestmentType type,
    required int currentAge,
  }) {
    final totalContributions = monthlyAmount * 12 * years;
    final monthlyRate = type.annualReturn / 12;
    final totalMonths = years * 12;
    
    // Calculate future value of annuity
    final futureValueContributions = monthlyAmount * 
        ((pow(1 + monthlyRate, totalMonths) - 1) / monthlyRate);
    
    // Calculate future value of current net worth
    final futureValueCurrentWealth = currentNetWorth * pow(1 + type.annualReturn, years);
    
    final finalAmount = futureValueContributions + futureValueCurrentWealth;
    final totalInterest = finalAmount - totalContributions - currentNetWorth;
    
    // Calculate future percentile
    final futureAge = min(55, currentAge + years);
    final futureAgeData = _getDataForAge(futureAge);
    final finalPercentile = _calculatePercentile(finalAmount, futureAgeData);
    
    return InvestmentSimulation(
      monthlyAmount: monthlyAmount,
      years: years,
      type: type,
      finalAmount: finalAmount,
      totalContributions: totalContributions,
      totalInterest: totalInterest,
      finalPercentile: finalPercentile,
    );
  }
}