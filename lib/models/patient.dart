class Patient {
  final String id;
  final String name;
  final int age;
  final String genotype;
  final String location;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.genotype,
    required this.location,
  });
}

abstract class HealthMeasurement {
  final String id;
  final DateTime date;

  HealthMeasurement({required this.id, required this.date});
}

class DailyCheckIn extends HealthMeasurement {
  final int painLevel;
  final int hydrationLevel;
  final bool tookMedication;
  final String mood;
  // New specific fields for Sickle Cell expanded tracking
  final String sleepQuality;
  final bool hasFever;
  final List<String> unusualSymptoms; // e.g. Swelling, Dizziness, Jaundice

  DailyCheckIn({
    required super.id,
    required super.date,
    required this.painLevel,
    required this.hydrationLevel,
    required this.tookMedication,
    required this.mood,
    this.sleepQuality = 'Neutral',
    this.hasFever = false,
    this.unusualSymptoms = const [],
  });
}

class DiabetesCheckIn extends HealthMeasurement {
  final double bloodSugarLevel;
  final bool isFasting;
  final bool tookInsulin;
  final int hydrationLevel;
  final String? dietNotes;
  final String physicalActivity;

  DiabetesCheckIn({
    required super.id,
    required super.date,
    required this.bloodSugarLevel,
    required this.isFasting,
    required this.tookInsulin,
    required this.hydrationLevel,
    this.dietNotes,
    required this.physicalActivity,
  });
}

class HypertensionCheckIn extends HealthMeasurement {
  final int systolic;
  final int diastolic;
  final bool tookMedication;
  final double weight;
  final String physicalActivity;
  final String stressLevel;

  HypertensionCheckIn({
    required super.id,
    required super.date,
    required this.systolic,
    required this.diastolic,
    required this.tookMedication,
    required this.weight,
    required this.physicalActivity,
    required this.stressLevel,
  });
}
