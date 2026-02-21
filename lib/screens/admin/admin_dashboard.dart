import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin / Portal'),
        actions: [
          IconButton(
            icon: const Icon(FeatherIcons.bell, color: AppColors.riskRed),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Text(
            'Health Professional Overview',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Monitor patient risk trends and hospital resources.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),

          // High Risk Alerts Panel
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassDecoration.copyWith(
              color: AppColors.riskRed.withOpacity(0.1),
              border: Border.all(color: AppColors.riskRed.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      FeatherIcons.alertTriangle,
                      color: AppColors.riskRed,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'High Risk Patients (Action Required)',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.riskRed,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildPatientRow(
                  context,
                  name: 'Jane Doe',
                  disease: 'Sickle Cell',
                  status: 'Critical Crisis',
                  time: '10 mins ago',
                ),
                const Divider(color: AppColors.border),
                _buildPatientRow(
                  context,
                  name: 'Mark Smith',
                  disease: 'Asthma',
                  status: 'Severe Attack',
                  time: '25 mins ago',
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Resource Availability
          Text(
            'Hospital Resource Map',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildResourceCard(
                  context,
                  title: 'ICU Beds',
                  value: '12 / 50 Available',
                  color: AppColors.riskYellow,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildResourceCard(
                  context,
                  title: 'Blood Units (O-)',
                  value: 'Low Stock',
                  color: AppColors.riskRed,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Predictive Insights
          Text(
            'AI Predictive Insights',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassDecoration,
            child: Column(
              children: [
                const Icon(
                  FeatherIcons.trendingUp,
                  color: AppColors.primary,
                  size: 32,
                ),
                const SizedBox(height: 16),
                Text(
                  'Expected 15% increase in malaria cases next week due to heavy rains. Recommend stockpiling antimalarials.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientRow(
    BuildContext context, {
    required String name,
    required String disease,
    required String status,
    required String time,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.surface,
            child: Text(name[0], style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '$disease - $status',
                  style: const TextStyle(fontSize: 12, color: Colors.redAccent),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context, {
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.glassDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
