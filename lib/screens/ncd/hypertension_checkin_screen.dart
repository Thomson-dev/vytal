import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/patient_provider.dart';
import '../../models/patient.dart';
import '../../theme/app_colors.dart';

class HypertensionCheckInScreen extends StatefulWidget {
  const HypertensionCheckInScreen({super.key});

  @override
  State<HypertensionCheckInScreen> createState() =>
      _HypertensionCheckInScreenState();
}

class _HypertensionCheckInScreenState extends State<HypertensionCheckInScreen> {
  double _systolic = 120;
  double _diastolic = 80;
  bool _tookMedication = true;
  double _weight = 70.0;
  String _physicalActivity = 'None';
  String _stressLevel = 'Low';

  final List<String> _activityLevels = [
    'None',
    'Light',
    'Moderate',
    'Vigorous',
  ];
  final List<String> _stressLevels = ['Low', 'Moderate', 'High', 'Severe'];

  void _submit() {
    final checkIn = HypertensionCheckIn(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      systolic: _systolic.toInt(),
      diastolic: _diastolic.toInt(),
      tookMedication: _tookMedication,
      weight: _weight,
      physicalActivity: _physicalActivity,
      stressLevel: _stressLevel,
    );

    context.read<PatientProvider>().addHypertensionCheckIn(checkIn);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('BP Log Saved. AI has updated your risk level.'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hypertension Tracking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blood Pressure
            Text(
              'Blood Pressure (mmHg)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Systolic (Top)',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      Slider(
                        value: _systolic,
                        min: 80,
                        max: 220,
                        divisions: 140,
                        activeColor: _systolic > 180
                            ? AppColors.riskRed
                            : _systolic > 130
                            ? AppColors.riskYellow
                            : AppColors.riskGreen,
                        label: _systolic.round().toString(),
                        onChanged: (value) => setState(() => _systolic = value),
                      ),
                      Center(
                        child: Text(
                          _systolic.round().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Diastolic (Bottom)',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      Slider(
                        value: _diastolic,
                        min: 50,
                        max: 130,
                        divisions: 80,
                        activeColor: _diastolic > 120
                            ? AppColors.riskRed
                            : _diastolic > 80
                            ? AppColors.riskYellow
                            : AppColors.riskGreen,
                        label: _diastolic.round().toString(),
                        onChanged: (value) =>
                            setState(() => _diastolic = value),
                      ),
                      Center(
                        child: Text(
                          _diastolic.round().toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 48, color: AppColors.border),

            // Medication
            Text(
              'Medication Adherence',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Did you take your prescribed BP meds?'),
              value: _tookMedication,
              activeColor: AppColors.primary,
              onChanged: (value) => setState(() => _tookMedication = value),
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(height: 48, color: AppColors.border),

            // Weight
            Text(
              'Weight Tracking (kg)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _weight,
                    min: 40,
                    max: 150,
                    divisions: 110,
                    activeColor: AppColors.primary,
                    label: _weight.toStringAsFixed(1),
                    onChanged: (value) => setState(() => _weight = value),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Text(
                    _weight.toStringAsFixed(1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 48, color: AppColors.border),

            // Activity
            Text(
              'Physical Activity',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _activityLevels.map((activity) {
                final isSelected = _physicalActivity == activity;
                return ChoiceChip(
                  label: Text(activity),
                  selected: isSelected,
                  selectedColor: AppColors.primary.withOpacity(0.2),
                  backgroundColor: AppColors.surface,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                  onSelected: (selected) {
                    if (selected) setState(() => _physicalActivity = activity);
                  },
                );
              }).toList(),
            ),
            const Divider(height: 48, color: AppColors.border),

            // Stress Level
            Text('Stress Level', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _stressLevels.map((stress) {
                final isSelected = _stressLevel == stress;
                return ChoiceChip(
                  label: Text(stress),
                  selected: isSelected,
                  selectedColor: AppColors.riskYellow.withOpacity(0.2),
                  backgroundColor: AppColors.surface,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.riskYellow
                        : AppColors.textPrimary,
                  ),
                  onSelected: (selected) {
                    if (selected) setState(() => _stressLevel = stress);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 64),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Save BP Log'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
