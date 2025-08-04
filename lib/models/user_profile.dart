class UserProfile {
  final int age;
  final double monthlyIncome;
  final double netWorth;
  final FamilyStatus familyStatus;

  UserProfile({
    required this.age,
    required this.monthlyIncome,
    required this.netWorth,
    required this.familyStatus,
  });

  Map<String, dynamic> toJson() => {
    'age': age,
    'monthlyIncome': monthlyIncome,
    'netWorth': netWorth,
    'familyStatus': familyStatus.name,
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    age: json['age'],
    monthlyIncome: json['monthlyIncome'].toDouble(),
    netWorth: json['netWorth'].toDouble(),
    familyStatus: FamilyStatus.values.firstWhere(
      (e) => e.name == json['familyStatus'],
    ),
  );
}

enum FamilyStatus {
  single('Célibataire'),
  couple('En couple'),
  coupleWithChildren('En couple avec enfants'),
  singleParent('Parent célibataire');

  const FamilyStatus(this.displayName);
  final String displayName;
}

class WealthRanking {
  final double percentile;
  final double medianForAge;
  final double nationalAverage;
  final String message;
  final bool isAboveAverage;

  WealthRanking({
    required this.percentile,
    required this.medianForAge,
    required this.nationalAverage,
    required this.message,
    required this.isAboveAverage,
  });
}

class InvestmentSimulation {
  final double monthlyAmount;
  final int years;
  final InvestmentType type;
  final double finalAmount;
  final double totalContributions;
  final double totalInterest;
  final double finalPercentile;

  InvestmentSimulation({
    required this.monthlyAmount,
    required this.years,
    required this.type,
    required this.finalAmount,
    required this.totalContributions,
    required this.totalInterest,
    required this.finalPercentile,
  });
}

enum InvestmentType {
  livretA('Livret A', 0.03),
  assuranceVie('Assurance-vie', 0.04),
  etf('ETF', 0.07),
  risky('Investissement risqué', 0.10);

  const InvestmentType(this.displayName, this.annualReturn);
  final String displayName;
  final double annualReturn;
}

class AIAdvice {
  final String title;
  final String content;
  final List<String> recommendations;
  final DateTime generatedAt;

  AIAdvice({
    required this.title,
    required this.content,
    required this.recommendations,
    required this.generatedAt,
  });
}