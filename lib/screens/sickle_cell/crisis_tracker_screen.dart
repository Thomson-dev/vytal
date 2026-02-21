import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import '../../providers/patient_provider.dart';
import '../../theme/app_colors.dart';
import 'emergency_marketplace_screen.dart';

class CrisisTrackerScreen extends StatefulWidget {
  const CrisisTrackerScreen({super.key});

  @override
  State<CrisisTrackerScreen> createState() => _CrisisTrackerScreenState();
}

class _CrisisTrackerScreenState extends State<CrisisTrackerScreen> {
  int _painScale = 1;
  bool _hasSwelling = false;
  bool _hasFever = false;
  bool _hasFatigue = false;
  bool _evaluated = false;

  void _evaluate() {
    context.read<PatientProvider>().evaluateCrisis(
      _painScale,
      _hasSwelling,
      _hasFever,
      _hasFatigue,
    );
    setState(() {
      _evaluated = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    RiskLevel riskLevel = context.watch<PatientProvider>().currentRiskLevel;

    return Scaffold(
      appBar: AppBar(title: const Text('Crisis Tracker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'AI Symptom Evaluator',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Answer these short questions to evaluate your current risk level.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 32),

            // Form
            Text(
              'Are you experiencing pain?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Slider(
              value: _painScale.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              label: _painScale.toString(),
              activeColor: AppColors.primary,
              onChanged: (value) => setState(() => _painScale = value.toInt()),
            ),
            const SizedBox(height: 16),

            SwitchListTile(
              title: const Text('Any swelling in hands or feet?'),
              value: _hasSwelling,
              activeColor: AppColors.primary,
              onChanged: (val) => setState(() => _hasSwelling = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Do you have a fever?'),
              value: _hasFever,
              activeColor: AppColors.primary,
              onChanged: (val) => setState(() => _hasFever = val),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile(
              title: const Text('Are you feeling unusually fatigued?'),
              value: _hasFatigue,
              activeColor: AppColors.primary,
              onChanged: (val) => setState(() => _hasFatigue = val),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _evaluate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: const Text('Evaluate Symptoms'),
              ),
            ),

            if (_evaluated) ...[
              const SizedBox(height: 48),
              _buildResultCard(context, riskLevel),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, RiskLevel level) {
    Color cardColor;
    String title;
    String message;
    IconData icon;
    bool showEmergencyAction = false;

    switch (level) {
      case RiskLevel.red:
        cardColor = AppColors.riskRed.withOpacity(0.2);
        icon = FeatherIcons.alertTriangle;
        title = 'High Risk Detected';
        message =
            'Your symptoms indicate a potential severe crisis. Please seek medical attention immediately.';
        showEmergencyAction = true;
        break;
      case RiskLevel.yellow:
        cardColor = AppColors.riskYellow.withOpacity(0.2);
        icon = FeatherIcons.alertCircle;
        title = 'Moderate Risk';
        message =
            'You are experiencing elevated symptoms. Hydrate, rest, and monitor closely.';
        break;
      case RiskLevel.green:
        cardColor = AppColors.riskGreen.withOpacity(0.2);
        icon = FeatherIcons.checkCircle;
        title = 'Low Risk';
        message =
            'Your symptoms are manageable. Keep monitoring your daily logs.';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70),
          ),
          if (showEmergencyAction) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EmergencyMarketplaceScreen(),
                    ),
                  );
                },
                icon: const Icon(FeatherIcons.mapPin),
                label: const Text('Find Nearest Hospital'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.riskRed,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
