import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class NcdAnalyticsScreen extends StatelessWidget {
  const NcdAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NCD Health Analytics')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Alert Box
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.glassDecoration.copyWith(
                border: Border.all(
                  color: AppColors.riskYellow.withOpacity(0.5),
                ),
                gradient: LinearGradient(
                  colors: [
                    AppColors.riskYellow.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    FeatherIcons.alertTriangle,
                    color: AppColors.riskYellow,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Predictive Alert',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: AppColors.riskYellow,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your blood pressure has been trending higher over the last 3 days. Consider reducing sodium intake and monitor closely.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Text(
              'Blood Pressure Trends',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Systolic vs Diastolic over 7 days',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 24),

            // Highlighting mock chart
            Container(
              height: 250,
              padding: const EdgeInsets.all(16),
              decoration: AppTheme.glassDecoration,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: const FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 20,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                      ),
                    ),
                  ),
                  minX: 1,
                  maxX: 7,
                  minY: 60,
                  maxY: 180,
                  lineBarsData: [
                    // Systolic
                    LineChartBarData(
                      spots: const [
                        FlSpot(1, 120),
                        FlSpot(2, 122),
                        FlSpot(3, 130),
                        FlSpot(4, 135),
                        FlSpot(5, 140),
                        FlSpot(6, 145),
                        FlSpot(7, 142),
                      ],
                      isCurved: true,
                      color: AppColors.riskRed,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                    ),
                    // Diastolic
                    LineChartBarData(
                      spots: const [
                        FlSpot(1, 80),
                        FlSpot(2, 82),
                        FlSpot(3, 85),
                        FlSpot(4, 88),
                        FlSpot(5, 90),
                        FlSpot(6, 95),
                        FlSpot(7, 92),
                      ],
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 48),

            Text(
              'Lifestyle Recommendations',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildRecommendationCard(
              context,
              icon: Icons.directions_walk,
              title: 'Increase Light Activity',
              description:
                  'Try adding a 15-minute walk after meals to help stabilize blood sugar and pressure.',
              color: Colors.green,
            ),
            const SizedBox(height: 12),
            _buildRecommendationCard(
              context,
              icon: Icons.water_drop,
              title: 'Hydration Target Missed',
              description:
                  'You averaged 4 glasses of water over the last 3 days. Aim for 8 glasses.',
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassDecoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
