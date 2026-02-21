import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import 'diabetes_checkin_screen.dart';
import 'hypertension_checkin_screen.dart';
import 'ncd_analytics_screen.dart';

class ChronicDiseaseHub extends StatelessWidget {
  const ChronicDiseaseHub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chronic Diseases (NCDs)')),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Info Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: AppTheme.glassDecoration.copyWith(
              gradient: const LinearGradient(
                colors: [Color(0xFF82C09A), Color(0xFF4FA874)],
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FeatherIcons.activity,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Manage Your NCDs',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Daily Tracking & Insights',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          Text(
            'Select Condition to Track',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          _buildActionCard(
            context,
            icon: Icons.bloodtype_outlined,
            title: 'Diabetes Management',
            subtitle: 'Log blood sugar, insulin, and diet',
            color: const Color(0xFF4FACFE), // Blue
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DiabetesCheckInScreen(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            context,
            icon: Icons.monitor_heart_outlined,
            title: 'Hypertension Tracking',
            subtitle: 'Log blood pressure, meds, and weight',
            color: AppColors.riskRed, // Red
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HypertensionCheckInScreen(),
              ),
            ),
          ),

          const SizedBox(height: 32),
          Text('NCD Resources', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),

          _buildActionCard(
            context,
            icon: FeatherIcons.pieChart,
            title: 'Health Analytics & Predictions',
            subtitle: 'View trends and AI alerts',
            color: const Color(0xFFF9C80E),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NcdAnalyticsScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: AppTheme.glassDecoration,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              FeatherIcons.chevronRight,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
