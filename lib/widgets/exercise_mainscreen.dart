import 'package:flutter/material.dart';
import 'package:workout_plan/models/exercise.dart';
import 'package:workout_plan/widgets/new_exercise.dart';
import 'package:workout_plan/widgets/exercise_list.dart';

/// The main screen for managing exercises in the Workout Planner application.
/// This screen displays a list of exercises, divided into incomplete and completed categories,
/// and allows users to add, delete, or toggle the completion status of exercises.
class ExerciseMainScreen extends StatefulWidget {
  /// Constructor for the [ExerciseMainScreen] widget.
  const ExerciseMainScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExerciseMainScreenState();
  }
}

class _ExerciseMainScreenState extends State<ExerciseMainScreen> {
  /// A list to store all exercises added by the user.
  final List<Exercise> aaddedExercise = [];

  /// Returns a list of exercises that are incomplete.
  List<Exercise> get incompleteExercises =>
      aaddedExercise.where((exercise) => !exercise.isCompleted).toList();

  /// Returns a list of exercises that are completed.
  List<Exercise> get completedExercises =>
      aaddedExercise.where((exercise) => exercise.isCompleted).toList();

  /// Adds a new exercise to the list.
  ///
  /// [newExercise] is the exercise instance to be added.
  void seenExercises(Exercise newExercise) {
    setState(() {
      aaddedExercise.add(newExercise);
    });
  }

  /// Toggles the completion status of an exercise.
  ///
  /// [id] is the unique identifier of the exercise to be updated.
  void toggleCompletion(String id) {
    setState(() {
      final exercise = aaddedExercise.firstWhere((e) => e.id == id);
      exercise.isCompleted = !exercise.isCompleted;
    });
  }

  /// Deletes an exercise from the list.
  ///
  /// [id] is the unique identifier of the exercise to be removed.
  void deleteExercise(String id) {
    setState(() {
      aaddedExercise.removeWhere((exercise) => exercise.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Workout Planner',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 136, 187, 224),
                Color.fromARGB(255, 6, 99, 175)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ExerciseList(
        incompleteExercises: incompleteExercises,
        completedExercises: completedExercises,
        toggleCompletion: toggleCompletion,
        deleteExercise: deleteExercise,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (_) => NewExercise(seenExercises));
        },
      ),
    );
  }
}
