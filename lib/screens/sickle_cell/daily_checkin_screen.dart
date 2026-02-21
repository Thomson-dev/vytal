import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/patient_provider.dart';
import '../../models/patient.dart';
import '../../theme/app_colors.dart';

class DailyCheckInScreen extends StatefulWidget {
  const DailyCheckInScreen({super.key});

  @override
  State<DailyCheckInScreen> createState() => _DailyCheckInScreenState();
}

class _DailyCheckInScreenState extends State<DailyCheckInScreen> {
  double _painLevel = 1;
  int _hydrationLevel = 3;
  bool _tookMedication = true;
  String _mood = 'Good';
  String _sleepQuality = 'Neutral';
  bool _hasFever = false;
  final List<String> _unusualSymptoms = [];

  final List<String> _moods = ['Good', 'Neutral', 'Fatigued', 'Stressed'];
  final List<String> _sleepOptions = ['Good', 'Neutral', 'Poor'];
  final List<String> _symptomOptions = [
    'Swelling',
    'Dizziness',
    'Jaundice',
    'Nausea',
    'Shortness of Breath',
  ];

  void _submit() {
    final checkIn = DailyCheckIn(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      painLevel: _painLevel.toInt(),
      hydrationLevel: _hydrationLevel,
      tookMedication: _tookMedication,
      mood: _mood,
      sleepQuality: _sleepQuality,
      hasFever: _hasFever,
      unusualSymptoms: _unusualSymptoms,
    );
    context.read<PatientProvider>().addDailyCheckIn(checkIn);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Daily Check-in Logged. AI has updated your status.'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Check-In')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pain Level (1-10)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.sentiment_very_satisfied, color: Colors.green),
                Expanded(
                  child: Slider(
                    value: _painLevel,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    activeColor: _painLevel > 7
                        ? AppColors.riskRed
                        : _painLevel > 4
                        ? AppColors.riskYellow
                        : AppColors.riskGreen,
                    label: _painLevel.round().toString(),
                    onChanged: (value) => setState(() => _painLevel = value),
                  ),
                ),
                const Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                ),
              ],
            ),
            const Divider(height: 48, color: AppColors.border),

            Text(
              'Hydration (Glasses per day)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _hydrationLevel = index + 1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _hydrationLevel > index
                          ? Colors.blueAccent.withOpacity(0.2)
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _hydrationLevel > index
                            ? Colors.blue
                            : AppColors.border,
                      ),
                    ),
                    child: Icon(
                      Icons.water_drop,
                      color: _hydrationLevel > index
                          ? Colors.blue
                          : AppColors.textSecondary,
                    ),
                  ),
                );
              }),
            ),
            const Divider(height: 48, color: AppColors.border),

            Text(
              'Medication Adherence',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Did you take your prescribed medication?'),
              value: _tookMedication,
              activeColor: AppColors.primary,
              onChanged: (value) => setState(() => _tookMedication = value),
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(height: 48, color: AppColors.border),

            Text(
              'Current Mood / Energy',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _moods.map((mood) {
                final isSelected = _mood == mood;
                return ChoiceChip(
                  label: Text(mood),
                  selected: isSelected,
                  selectedColor: AppColors.primary.withOpacity(0.2),
                  backgroundColor: AppColors.surface,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                  onSelected: (selected) {
                    if (selected) setState(() => _mood = mood);
                  },
                );
              }).toList(),
            ),
            const Divider(height: 48, color: AppColors.border),

            Text(
              'Sleep Quality',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _sleepOptions.map((sleep) {
                final isSelected = _sleepQuality == sleep;
                return ChoiceChip(
                  label: Text(sleep),
                  selected: isSelected,
                  selectedColor: AppColors.primary.withOpacity(0.2),
                  backgroundColor: AppColors.surface,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textPrimary,
                  ),
                  onSelected: (selected) {
                    if (selected) setState(() => _sleepQuality = sleep);
                  },
                );
              }).toList(),
            ),
            const Divider(height: 48, color: AppColors.border),

            Text('Symptoms', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Do you have a fever?'),
              value: _hasFever,
              activeColor: AppColors.riskRed,
              onChanged: (value) => setState(() => _hasFever = value),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 16),
            Text(
              'Unusual Symptoms (Select all that apply)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _symptomOptions.map((symptom) {
                final isSelected = _unusualSymptoms.contains(symptom);
                return FilterChip(
                  label: Text(symptom),
                  selected: isSelected,
                  selectedColor: AppColors.riskYellow.withOpacity(0.2),
                  backgroundColor: AppColors.surface,
                  checkmarkColor: AppColors.riskYellow,
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.riskYellow
                        : AppColors.textPrimary,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _unusualSymptoms.add(symptom);
                      } else {
                        _unusualSymptoms.remove(symptom);
                      }
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 64),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Save Check-In'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
