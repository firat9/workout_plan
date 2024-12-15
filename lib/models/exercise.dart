import 'package:uuid/uuid.dart';

/// Enum representing the intensity levels of an exercise.
/// - `low`: Low intensity level.
/// - `medium`: Medium intensity level.
/// - `high`: High intensity level.
enum Intensity {
  low,
  medium,
  high,
}

/// A class that represents an exercise item.
///
/// Each exercise has a unique ID, a title, duration (in minutes),
/// a completion status, and an intensity level.
class Exercise {
  /// Creates an [Exercise] instance with the given parameters.
  ///
  /// [title] - The name/title of the exercise.
  /// [duration] - Duration of the exercise in minutes.
  /// [isCompleted] - Boolean to track if the exercise is completed.
  /// [intensity] - The intensity level of the exercise.
  Exercise({
    required this.title,
    required this.duration,
    required this.isCompleted,
    required this.intensity,
  }) : id = const Uuid().v4();

  /// The title/name of the exercise.
  final String title;

  /// Duration of the exercise in minutes.
  final int duration;

  /// Tracks if the exercise is completed.
  bool isCompleted;

  /// The intensity level of the exercise.
  final Intensity intensity;

  /// A unique identifier for the exercise.
  final String id;
}
