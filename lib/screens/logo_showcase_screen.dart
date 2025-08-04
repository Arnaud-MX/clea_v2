import 'package:flutter/material.dart';
import 'package:clea/widgets/clea_logo.dart';
import 'package:clea/widgets/app_welcome_logo.dart';

/// Écran pour démontrer les différentes variantes du logo Cléa
class LogoShowcaseScreen extends StatelessWidget {
  const LogoShowcaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logo Cléa - Variantes'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: AppWelcomeBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                context,
                'Logo seul - Variations de taille',
                [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CleaLogo(size: 60),
                      CleaLogo(size: 80),
                      CleaLogo(size: 100),
                    ],
                  ),
                ],
              ),
              
              _buildSection(
                context,
                'Formes - Rond vs Carré arrondi',
                [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CleaLogo.round(size: 100),
                          SizedBox(height: 8),
                          Text('Rond', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          CleaLogo.square(size: 100),
                          SizedBox(height: 8),
                          Text('Carré arrondi', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              
              _buildSection(
                context,
                'Avec et sans ombre',
                [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CleaLogo(size: 100, showShadow: true),
                          SizedBox(height: 8),
                          Text('Avec ombre', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      Column(
                        children: [
                          CleaLogo(size: 100, showShadow: false),
                          SizedBox(height: 8),
                          Text('Sans ombre', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              
              _buildSection(
                context,
                'Logo complet avec nom',
                [
                  const Center(
                    child: CleaAppLogo(
                      logoSize: 120,
                      spacing: 20,
                    ),
                  ),
                ],
              ),
              
              _buildSection(
                context,
                'Différentes tailles complètes',
                [
                  const Column(
                    children: [
                      CleaAppLogo(logoSize: 80, textSize: 24),
                      SizedBox(height: 32),
                      CleaAppLogo(logoSize: 100, textSize: 32),
                      SizedBox(height: 32),
                      CleaAppLogo(logoSize: 140, textSize: 40),
                    ],
                  ),
                ],
              ),
              
              _buildSection(
                context,
                'Optimisé pour écran d\'accueil',
                [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        AppWelcomeLogo(
                          size: 140,
                          showAppName: true,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Version optimisée pour écran d\'accueil mobile',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}