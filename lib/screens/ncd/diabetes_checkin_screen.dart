import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/patient_provider.dart';
import '../../models/patient.dart';
import '../../theme/app_colors.dart';

class DiabetesCheckInScreen extends StatefulWidget {
  const DiabetesCheckInScreen({super.key});

  @override
  State<DiabetesCheckInScreen> createState() => _DiabetesCheckInScreenState();
}

class _DiabetesCheckInScreenState extends State<DiabetesCheckInScreen> {
  double _bloodSugar = 100;
  bool _isFasting = true;
  bool _tookInsulin = true;
  int _hydrationLevel = 3;
  final TextEditingController _dietController = TextEditingController();
  String _physicalActivity = 'None';

  final List<String> _activityLevels = [
    'None',
    'Light',
    'Moderate',
    'Vigorous',
  ];

  void _submit() {
    final checkIn = DiabetesCheckIn(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      date: DateTime.now(),
      bloodSugarLevel: _bloodSugar,
      isFasting: _isFasting,
      tookInsulin: _tookInsulin,
      hydrationLevel: _hydrationLevel,
      dietNotes: _dietController.text.isNotEmpty ? _dietController.text : null,
      physicalActivity: _physicalActivity,
    );

    context.read<PatientProvider>().addDiabetesCheckIn(checkIn);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Diabetes Log Saved. AI has updated your risk level.'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _dietController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diabetes Tracking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blood Sugar Section
            Text(
              'Blood Sugar Level (mg/dL)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Slider(
                    value: _bloodSugar,
                    min: 40,
                    max: 400,
                    divisions: 360,
                    activeColor: _bloodSugar > 250 || _bloodSugar < 70
                        ? AppColors.riskRed
                        : _bloodSugar > 180
                        ? AppColors.riskYellow
                        : AppColors.riskGreen,
                    label: _bloodSugar.round().toString(),
                    onChanged: (value) => setState(() => _bloodSugar = value),
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
                    _bloodSugar.round().toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SwitchListTile(
              title: const Text('Is this a fasting reading?'),
              value: _isFasting,
              activeColor: AppColors.primary,
              onChanged: (value) => setState(() => _isFasting = value),
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(height: 48, color: AppColors.border),

            // Medication
            Text(
              'Medication / Insulin',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Did you take your prescribed dose?'),
              value: _tookInsulin,
              activeColor: AppColors.primary,
              onChanged: (value) => setState(() => _tookInsulin = value),
              contentPadding: EdgeInsets.zero,
            ),
            const Divider(height: 48, color: AppColors.border),

            // Hydration
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

            // Diet Notes
            Text(
              'Diet Notes (Optional)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _dietController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'What did you eat today? Any major sugar spikes?',
              ),
            ),

            const SizedBox(height: 64),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submit,
                child: const Text('Save Diabetes Log'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
