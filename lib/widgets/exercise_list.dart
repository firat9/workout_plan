import 'package:flutter/material.dart';
import 'package:workout_plan/models/exercise.dart';
import 'package:workout_plan/utils/constants.dart';

/// A widget that displays lists of incomplete and completed exercises.
///
/// It separates exercises into two categories: incomplete and completed,
/// and provides functionality to toggle completion and delete exercises.
class ExerciseList extends StatelessWidget {
  /// Constructor for ExerciseList widget.
  ///
  /// [incompleteExercises] - List of exercises that are not yet completed.
  /// [completedExercises] - List of exercises that are marked as completed.
  /// [toggleCompletion] - Callback function to toggle the completion status of an exercise.
  /// [deleteExercise] - Callback function to delete an exercise.
  const ExerciseList({
    super.key,
    required this.incompleteExercises,
    required this.completedExercises,
    required this.toggleCompletion,
    required this.deleteExercise,
  });

  /// List of incomplete exercises.
  final List<Exercise> incompleteExercises;

  /// List of completed exercises.
  final List<Exercise> completedExercises;

  /// Callback function to toggle the completion status of an exercise.
  final void Function(String id) toggleCompletion;

  /// Callback function to delete an exercise.
  final void Function(String id) deleteExercise;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: kPaddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Render incomplete exercises section if not empty.
            if (incompleteExercises.isNotEmpty) ...[
              Text(
                'Incomplete Exercises',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 8),
              ...incompleteExercises.map(
                (exercise) => _buildDismissibleCard(
                  exercise,
                  toggleCompletion,
                  deleteExercise,
                  context,
                  isCompleted: false,
                ),
              ),
            ],

            // Render completed exercises section if not empty.
            if (completedExercises.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Completed Exercises',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 8),
              ...completedExercises.map(
                (exercise) => _buildDismissibleCard(
                  exercise,
                  toggleCompletion,
                  deleteExercise,
                  context,
                  isCompleted: true,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Builds a dismissible card for displaying an exercise.
  ///
  /// Allows swipe-to-delete functionality.
  Widget _buildDismissibleCard(
    Exercise exercise,
    void Function(String id) toggleCompletion,
    void Function(String id) deleteExercise,
    BuildContext context, {
    required bool isCompleted,
  }) {
    return Dismissible(
      key: ValueKey(exercise.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => deleteExercise(exercise.id),
      child: _buildExerciseCard(
        exercise,
        toggleCompletion,
        deleteExercise,
        context,
        isCompleted: isCompleted,
      ),
    );
  }

  /// Builds a card widget for displaying an exercise.
  ///
  /// [exercise] - The exercise to display.
  /// [toggleCompletion] - Callback to toggle the completion status.
  /// [deleteExercise] - Callback to delete the exercise.
  /// [context] - Build context.
  /// [isCompleted] - Indicates whether the exercise is completed.
  Widget _buildExerciseCard(
    Exercise exercise,
    void Function(String id) toggleCompletion,
    void Function(String id) deleteExercise,
    BuildContext context, {
    required bool isCompleted,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: kCardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardBorderRadius),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: intensityColors[exercise.intensity]!,
          child: Text(
            exercise.intensity.name[0].toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(exercise.title),
        subtitle:
            Text('${exercise.duration} mins - ${exercise.intensity.name}'),
        trailing: isCompleted
            ? const Icon(Icons.check_circle, color: Colors.green)
            : const Icon(Icons.circle_outlined, color: Colors.red),
        onTap: () => toggleCompletion(exercise.id),
        onLongPress: () => deleteExercise(exercise.id),
      ),
    );
  }
}
