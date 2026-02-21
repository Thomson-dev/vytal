import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class EmergencyMarketplaceScreen extends StatelessWidget {
  const EmergencyMarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> hospitals = [
      {
        'name': 'St. Nicholas Hospital',
        'distance': '2.4 km away',
        'availability': 'High',
        'resources': ['Blood Bank', 'ICU Beds', 'Hematologist On-Call'],
        'color': AppColors.riskGreen,
      },
      {
        'name': 'Lagos University Teaching Hospital',
        'distance': '6.1 km away',
        'availability': 'Medium',
        'resources': ['Blood Bank', 'Pediatric Unit'],
        'color': AppColors.riskYellow,
      },
      {
        'name': 'Reddingcare Specialist Hospital',
        'distance': '8.3 km away',
        'availability': 'Low',
        'resources': ['ICU Beds'],
        'color': AppColors.riskRed,
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Emergency Health Marketplace')),
      body: ListView.builder(
        padding: const EdgeInsets.all(24.0),
        itemCount: hospitals.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Recommended Hospitals',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Based on your location and real-time resource availability.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          final hospital = hospitals[index - 1];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.glassDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        hospital['name'],
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: hospital['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        hospital['availability'],
                        style: TextStyle(
                          color: hospital['color'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      FeatherIcons.mapPin,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      hospital['distance'],
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: (hospital['resources'] as List<String>).map((res) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        res,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(FeatherIcons.phone),
                        label: const Text('Call'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(FeatherIcons.navigation),
                        label: const Text('Navigate'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
