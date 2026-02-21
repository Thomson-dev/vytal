import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../providers/patient_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PatientProvider>();
    final patient = provider.currentPatient;
    final riskLevel = provider.currentRiskLevel;
    final checkInCount = provider.checkIns.length;

    final riskColor = riskLevel == RiskLevel.red
        ? AppColors.riskRed
        : riskLevel == RiskLevel.yellow
        ? AppColors.riskYellow
        : AppColors.riskGreen;

    final riskLabel = riskLevel == RiskLevel.red
        ? 'High Risk'
        : riskLevel == RiskLevel.yellow
        ? 'Moderate'
        : 'Stable';

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          // Header
          Text('My Profile', style: Theme.of(context).textTheme.displayMedium),
          const SizedBox(height: 24),

          // Avatar + Name Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: AppTheme.glassDecoration.copyWith(
              gradient: AppColors.primaryGradient,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: Text(
                    (patient?.name.isNotEmpty == true)
                        ? patient!.name[0].toUpperCase()
                        : 'P',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient?.name ?? 'Patient',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Genotype: ${patient?.genotype ?? 'N/A'}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            FeatherIcons.mapPin,
                            size: 12,
                            color: Colors.white60,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            patient?.location ?? 'Unknown',
                            style: const TextStyle(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  label: 'Age',
                  value: '${patient?.age ?? '--'}',
                  icon: FeatherIcons.user,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  label: 'Check-Ins',
                  value: '$checkInCount',
                  icon: FeatherIcons.calendar,
                  color: const Color(0xFF4FACFE),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard(
                  context,
                  label: 'AI Status',
                  value: riskLabel,
                  icon: FeatherIcons.shield,
                  color: riskColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Account Settings
          Text('Account', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _buildMenuTile(
            context,
            icon: FeatherIcons.edit3,
            title: 'Edit Profile',
            subtitle: 'Update your name, location, and details',
            onTap: () {},
          ),
          _buildMenuTile(
            context,
            icon: FeatherIcons.bell,
            title: 'Notifications',
            subtitle: 'Manage medication and health alerts',
            onTap: () {},
          ),
          _buildMenuTile(
            context,
            icon: FeatherIcons.lock,
            title: 'Privacy & Security',
            subtitle: 'Manage your data and permissions',
            onTap: () {},
          ),
          const SizedBox(height: 24),

          // Health Records
          Text('Health Records', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _buildMenuTile(
            context,
            icon: FeatherIcons.fileText,
            title: 'My Medical Reports',
            subtitle: 'View and manage uploaded documents',
            onTap: () {},
          ),
          _buildMenuTile(
            context,
            icon: FeatherIcons.activity,
            title: 'Check-In History',
            subtitle: '$checkInCount entries logged',
            onTap: () {},
          ),
          const SizedBox(height: 24),

          // Support
          Text('Support', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          _buildMenuTile(
            context,
            icon: FeatherIcons.helpCircle,
            title: 'Help & FAQs',
            subtitle: 'Get answers to common questions',
            onTap: () {},
          ),
          _buildMenuTile(
            context,
            icon: FeatherIcons.messageCircle,
            title: 'Contact Support',
            subtitle: 'Reach out to our healthcare team',
            onTap: () {},
          ),
          const SizedBox(height: 32),

          // Logout
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                context.read<PatientProvider>().logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              icon: const Icon(FeatherIcons.logOut, color: AppColors.riskRed),
              label: const Text(
                'Log Out',
                style: TextStyle(color: AppColors.riskRed),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.riskRed),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Vytal v1.0.0 • Powered by AI',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondary.withOpacity(0.5),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: AppTheme.glassDecoration,
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: AppTheme.glassDecoration,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              FeatherIcons.chevronRight,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
