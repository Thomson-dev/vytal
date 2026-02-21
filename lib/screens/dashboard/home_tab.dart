import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../providers/patient_provider.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';
import '../sickle_cell/sickle_cell_hub.dart';
import '../ncd/chronic_disease_hub.dart';
import '../secondary/secondary_records_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = context.watch<PatientProvider>().currentPatient;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${patient?.name.split(' ').first ?? 'Patient'}',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'How are you feeling today?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.surface,
                child: Icon(FeatherIcons.bell, color: AppColors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Health Summary Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: AppTheme.glassDecoration.copyWith(
              gradient: AppColors.primaryGradient,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Health Summary',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your vitals and tracking logs indicate a stable condition. Remember to hydrate.',
                        style: TextStyle(color: Colors.white70, height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    FeatherIcons.shield,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Categories Title
          Text('Categories', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),

          // Grid of categories
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
            children: [
              _buildCategoryCard(
                context,
                title: 'Genetic',
                subtitle: 'Sickle Cell, CF',
                icon: FeatherIcons.target,
                color: const Color(0xFFE0B0FF), // Soft Purple
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SickleCellHub(),
                    ),
                  );
                },
              ),
              _buildCategoryCard(
                context,
                title: 'Chronic',
                subtitle: 'Diabetes, BP',
                icon: FeatherIcons.activity,
                color: const Color(0xFF82C09A), // Soft Green
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChronicDiseaseHub(),
                    ),
                  );
                },
              ),
              _buildCategoryCard(
                context,
                title: 'Allergy',
                subtitle: 'Triggers & Meds',
                icon: FeatherIcons.wind,
                color: const Color(0xFFFFB6C1), // Light Pink
                onTap: () {},
              ),
              _buildCategoryCard(
                context,
                title: 'Secondary',
                subtitle: 'Upload Family Records',
                icon: FeatherIcons.fileText,
                color: const Color(0xFFFFDAB9), // Peach
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SecondaryRecordsScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.glassDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const Spacer(),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
