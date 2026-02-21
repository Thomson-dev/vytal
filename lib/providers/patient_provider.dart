import 'package:flutter/material.dart';
import '../models/patient.dart';

enum RiskLevel { green, yellow, red }

class PatientProvider with ChangeNotifier {
  Patient? _currentPatient;
  List<DailyCheckIn> _checkIns = [];
  List<DiabetesCheckIn> _diabetesCheckIns = [];
  List<HypertensionCheckIn> _hypertensionCheckIns = [];
  RiskLevel _currentRiskLevel = RiskLevel.green;

  Patient? get currentPatient => _currentPatient;
  List<DailyCheckIn> get checkIns => _checkIns;
  List<DiabetesCheckIn> get diabetesCheckIns => _diabetesCheckIns;
  List<HypertensionCheckIn> get hypertensionCheckIns => _hypertensionCheckIns;
  RiskLevel get currentRiskLevel => _currentRiskLevel;

  void registerPatient({
    required String name,
    required int age,
    required String genotype,
    required String location,
  }) {
    _currentPatient = Patient(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      age: age,
      genotype: genotype,
      location: location,
    );
    notifyListeners();
  }

  void login(String phoneOrEmail) {
    // Mocking login for testing UI
    _currentPatient = Patient(
      id: 'mock_1',
      name: 'John Doe',
      age: 28,
      genotype: 'SS',
      location: 'Lagos, Nigeria',
    );
    notifyListeners();
  }

  void addDailyCheckIn(DailyCheckIn checkIn) {
    _checkIns.insert(0, checkIn);
    _evaluateRisk(checkIn);
    notifyListeners();
  }

  void evaluateCrisis(int pain, bool swelling, bool fever, bool fatigue) {
    // Mock AI Risk Evaluation algorithm
    int score = pain;
    if (swelling) score += 3;
    if (fever) score += 3;
    if (fatigue) score += 2;

    if (score >= 8) {
      _currentRiskLevel = RiskLevel.red;
    } else if (score >= 5) {
      _currentRiskLevel = RiskLevel.yellow;
    } else {
      _currentRiskLevel = RiskLevel.green;
    }
    notifyListeners();
  }

  void addDiabetesCheckIn(DiabetesCheckIn checkIn) {
    _diabetesCheckIns.insert(0, checkIn);
    _evaluateDiabetesRisk(checkIn);
    notifyListeners();
  }

  void addHypertensionCheckIn(HypertensionCheckIn checkIn) {
    _hypertensionCheckIns.insert(0, checkIn);
    _evaluateHypertensionRisk(checkIn);
    notifyListeners();
  }

  void _evaluateRisk(DailyCheckIn checkIn) {
    int score = checkIn.painLevel;
    if (checkIn.hydrationLevel < 3) score += 2;
    if (!checkIn.tookMedication) score += 3;
    if (checkIn.mood == 'Fatigued' || checkIn.mood == 'Stressed') score += 2;
    if (checkIn.sleepQuality == 'Poor') score += 2;
    if (checkIn.hasFever) score += 4;
    if (checkIn.unusualSymptoms.isNotEmpty)
      score += checkIn.unusualSymptoms.length * 2;

    _updateRiskLevel(score);
  }

  void _evaluateDiabetesRisk(DiabetesCheckIn checkIn) {
    int score = 0;
    // Basic mock logic: Hypoglycemia (< 70) or extreme Hyperglycemia (> 250) is red
    if (checkIn.bloodSugarLevel < 70) {
      score = 10;
    } else if (checkIn.bloodSugarLevel > 250) {
      score = 8;
    } else if (checkIn.bloodSugarLevel > 180) {
      score = 5; // Yellow
    }

    if (!checkIn.tookInsulin) score += 3;

    _updateRiskLevel(score);
  }

  void _evaluateHypertensionRisk(HypertensionCheckIn checkIn) {
    int score = 0;
    // Basic mock logic based on AHA guidelines
    if (checkIn.systolic > 180 || checkIn.diastolic > 120) {
      score = 10; // Hypertensive Crisis
    } else if (checkIn.systolic >= 140 || checkIn.diastolic >= 90) {
      score = 6; // Stage 2 Hypertension
    } else if (checkIn.systolic >= 130 || checkIn.diastolic >= 80) {
      score = 4; // Stage 1 Hypertension
    }

    if (!checkIn.tookMedication) score += 3;

    _updateRiskLevel(score);
  }

  void _updateRiskLevel(int score) {
    if (score >= 8) {
      _currentRiskLevel = RiskLevel.red;
    } else if (score >= 5) {
      _currentRiskLevel = RiskLevel.yellow;
    } else {
      _currentRiskLevel = RiskLevel.green;
    }
  }

  void logout() {
    _currentPatient = null;
    _checkIns.clear();
    _currentRiskLevel = RiskLevel.green;
    notifyListeners();
  }
}
