import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:clea/models/user_profile.dart';
import 'package:clea/widgets/custom_button.dart';
import 'package:clea/widgets/custom_card.dart';
import 'package:clea/screens/ranking_screen.dart';
import 'package:clea/utils/responsive_utils.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pageController = PageController();
  
  int _currentStep = 0;
  final int _totalSteps = 4;
  
  int? _age;
  double? _monthlyIncome;
  double? _netWorth;
  FamilyStatus? _familyStatus;
  
  final _ageController = TextEditingController();
  final _incomeController = TextEditingController();
  final _wealthController = TextEditingController();

  @override
  void dispose() {
    _pageController.dispose();
    _ageController.dispose();
    _incomeController.dispose();
    _wealthController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _allFieldsComplete()) {
      final profile = UserProfile(
        age: _age!,
        monthlyIncome: _monthlyIncome!,
        netWorth: _netWorth!,
        familyStatus: _familyStatus!,
      );
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RankingScreen(profile: profile),
        ),
      );
    }
  }

  bool _allFieldsComplete() {
    return _age != null &&
           _monthlyIncome != null &&
           _netWorth != null &&
           _familyStatus != null;
  }

  bool _canProceed() {
    switch (_currentStep) {
      case 0:
        return _age != null;
      case 1:
        return _monthlyIncome != null;
      case 2:
        return _netWorth != null;
      case 3:
        return _familyStatus != null;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes informations'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ResponsiveContainer(
        applyHorizontalPadding: false,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildProgressIndicator(theme),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildAgeStep(theme),
                    _buildIncomeStep(theme),
                    _buildWealthStep(theme),
                    _buildFamilyStatusStep(theme),
                  ],
                ),
              ),
              _buildNavigationButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(ThemeData theme) {
    return Container(
      padding: context.getPadding(
        mobile: const EdgeInsets.all(24),
        tablet: const EdgeInsets.all(32),
        desktop: const EdgeInsets.all(40),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(_totalSteps, (index) {
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index < _totalSteps - 1 ? 8 : 0),
                  decoration: BoxDecoration(
                    color: index <= _currentStep
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 12),
          Text(
            'Étape ${_currentStep + 1} sur $_totalSteps',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgeStep(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quel est ton âge ?',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nous utilisons cette information pour te comparer aux Français de ta tranche d\'âge',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 32),
          CustomCard(
            child: Column(
              children: [
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(2),
                  ],
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: '25',
                    hintStyle: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                    suffixText: 'ans',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _age = int.tryParse(value);
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre âge';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 18 || age > 65) {
                      return 'Veuillez saisir un âge entre 18 et 65 ans';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeStep(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quel est ton revenu mensuel net ?',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Salaire net après impôts et cotisations sociales',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 32),
          CustomCard(
            child: TextFormField(
              controller: _incomeController,
              keyboardType: TextInputType.number,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '2 500',
                hintStyle: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                suffixText: '€/mois',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _monthlyIncome = double.tryParse(value.replaceAll(',', '.'));
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre revenu mensuel';
                }
                final income = double.tryParse(value.replaceAll(',', '.'));
                if (income == null || income < 0) {
                  return 'Veuillez saisir un montant valide';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWealthStep(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quel est ton patrimoine net ?',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.info_outline,
                size: 16,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Immobilier net + placements + épargne - dettes',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          CustomCard(
            child: TextFormField(
              controller: _wealthController,
              keyboardType: TextInputType.number,
              style: theme.textTheme.headlineMedium,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '50 000',
                hintStyle: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                suffixText: '€',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  _netWorth = double.tryParse(value.replaceAll(',', '.'));
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir votre patrimoine net';
                }
                final wealth = double.tryParse(value.replaceAll(',', '.'));
                if (wealth == null) {
                  return 'Veuillez saisir un montant valide';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFamilyStatusStep(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quelle est ta situation familiale ?',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cette information nous aide à personnaliser nos conseils',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 32),
          ...FamilyStatus.values.map((status) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: CustomCard(
                onTap: () {
                  setState(() {
                    _familyStatus = status;
                  });
                },
                backgroundColor: _familyStatus == status
                    ? theme.colorScheme.primaryContainer
                    : null,
                child: Row(
                  children: [
                    Radio<FamilyStatus>(
                      value: status,
                      groupValue: _familyStatus,
                      onChanged: (value) {
                        setState(() {
                          _familyStatus = value;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        status.displayName,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: _familyStatus == status
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: CustomButton(
                text: 'Précédent',
                type: ButtonType.outline,
                onPressed: _previousStep,
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            flex: _currentStep == 0 ? 1 : 1,
            child: CustomButton(
              text: _currentStep == _totalSteps - 1 ? 'Calculer mon classement' : 'Suivant',
              icon: _currentStep == _totalSteps - 1 ? Icons.calculate : Icons.arrow_forward,
              onPressed: _canProceed() ? _nextStep : null,
            ),
          ),
        ],
      ),
    );
  }
}