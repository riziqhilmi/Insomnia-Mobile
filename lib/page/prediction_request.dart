class PredictionRequest {
  final String year;
  final String gender;
  final String sleepHours;
  final String concentrationDifficulty;
  final String missClass;
  final String deviceUse;
  final String caffeine;
  final String exercise;
  final String stressLevel;
  final String academicPerformance;

  PredictionRequest({
    required this.year,
    required this.gender,
    required this.sleepHours,
    required this.concentrationDifficulty,
    required this.missClass,
    required this.deviceUse,
    required this.caffeine,
    required this.exercise,
    required this.stressLevel,
    required this.academicPerformance,
  });

  Map<String, dynamic> toJson() => {
        'year': year,
        'gender': gender,
        'sleep_hours': sleepHours,
        'concentration_difficulty': concentrationDifficulty,
        'miss_class': missClass,
        'device_use': deviceUse,
        'caffeine': caffeine,
        'exercise': exercise,
        'stress_level': stressLevel,
        'academic_performance': academicPerformance,
      };
}
