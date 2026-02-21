import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../../providers/patient_provider.dart';
import 'daily_checkin_screen.dart';
import 'crisis_tracker_screen.dart';
import 'emergency_marketplace_screen.dart';
import 'community_screen.dart';
import 'analytics_screen.dart';

class SickleCellHub extends StatelessWidget {
  const SickleCellHub({super.key});

  @override
  Widget build(BuildContext context) {
    final riskLevel = context.watch<PatientProvider>().currentRiskLevel;

    // Determine gradient based on risk level
    LinearGradient riskGradient;
    String riskStatus;
    IconData riskIcon;

    switch (riskLevel) {
      case RiskLevel.red:
        riskGradient = LinearGradient(
          colors: [Colors.redAccent.shade700, Colors.red.shade900],
        );
        riskStatus = 'High Risk - Immediate Attention Required';
        riskIcon = FeatherIcons.alertTriangle;
        break;
      case RiskLevel.yellow:
        riskGradient = LinearGradient(
          colors: [Colors.orangeAccent.shade700, Colors.orange.shade900],
        );
        riskStatus = 'Moderate Risk - Monitor Closely';
        riskIcon = FeatherIcons.alertCircle;
        break;
      case RiskLevel.green:
        riskGradient = const LinearGradient(
          colors: [Color(0xFF20BF55), Color(0xFF01BAEF)],
        );
        riskStatus = 'Stable - Keep up the good work!';
        riskIcon = FeatherIcons.checkCircle;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Sickle Cell Care')),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Dynamic Risk Status Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: AppTheme.glassDecoration.copyWith(
              gradient: riskGradient,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(riskIcon, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Status Assessment',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        riskStatus,
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
            'Daily Management',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),

          _buildActionCard(
            context,
            icon: FeatherIcons.calendar,
            title: 'Daily Check-In',
            subtitle: 'Log your pain, hydration, and mood',
            color: const Color(0xFF4FACFE),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DailyCheckInScreen(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            context,
            icon: FeatherIcons.activity,
            title: 'Crisis Evaluator',
            subtitle: 'AI-powered questionnaire for acute symptoms',
            color: AppColors.riskRed,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CrisisTrackerScreen(),
              ),
            ),
          ),

          const SizedBox(height: 32),
          Text('Resources', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),

          _buildActionCard(
            context,
            icon: FeatherIcons.mapPin,
            title: 'Emergency Marketplace',
            subtitle: 'Find nearby hospitals and blood banks',
            color: const Color(0xFF00F2FE),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EmergencyMarketplaceScreen(),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            context,
            icon: FeatherIcons.users,
            title: 'Community Support',
            subtitle: 'Connect with peers & share experiences',
            color: const Color(0xFF9D4EDD),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CommunityScreen()),
            ),
          ),
          const SizedBox(height: 12),
          _buildActionCard(
            context,
            icon: FeatherIcons.barChart2,
            title: 'Health Analytics',
            subtitle: 'Symptom trends and history',
            color: const Color(0xFFF9C80E),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AnalyticsScreen()),
            ),
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
