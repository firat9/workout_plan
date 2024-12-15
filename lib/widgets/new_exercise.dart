import 'package:flutter/material.dart';
import 'package:workout_plan/models/exercise.dart';
import 'package:workout_plan/utils/constants.dart';

/// A StatefulWidget that provides a form for adding a new exercise.
///
/// [onAdding] - A callback function that is called when a new exercise
/// is successfully added.
class NewExercise extends StatefulWidget {
  const NewExercise(this.onAdding, {super.key});

  final void Function(Exercise exercise) onAdding;

  @override
  State<StatefulWidget> createState() {
    return _NewExerciseState();
  }
}

/// State class for the [NewExercise] widget.
///
/// Manages user input for exercise name, duration, and intensity.
/// It validates the inputs and passes the exercise data back to the parent
/// via the [onAdding] callback.
class _NewExerciseState extends State<NewExercise> {
  final _textController = TextEditingController();
  final _durationController = TextEditingController();
  bool isCompleted = false;
  Intensity? _selectedIntensity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPaddingAll, // Use padding from constants.dart
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(kCardBorderRadius),
          topRight: Radius.circular(kCardBorderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5, // Shadow effect
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header row with the title and close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Exercise',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            /// TextField for the exercise name input
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Exercise Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kCardBorderRadius),
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// TextField for the exercise duration input
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Duration (Minutes)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kCardBorderRadius),
                ),
                suffixIcon: const Icon(Icons.timer),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),

            /// Dropdown menu for selecting exercise intensity
            DropdownButtonFormField<Intensity>(
              decoration: InputDecoration(
                labelText: 'Intensity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kCardBorderRadius),
                ),
              ),
              items: Intensity.values.map((intensity) {
                return DropdownMenuItem(
                  value: intensity,
                  child: Text(intensity.name.toUpperCase()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedIntensity = value;
                });
              },
            ),
            const SizedBox(height: 20),

            /// Save button that validates input and adds the exercise
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      final duration =
                          double.tryParse(_durationController.text);

                      // Input validation for all fields
                      if (_textController.text.trim().isEmpty ||
                          duration == null ||
                          duration <= 0 ||
                          _selectedIntensity == null) {
                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Invalid Input'),
                            content: const Text('Please fill all fields.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        return;
                      }

                      // Callback to pass new exercise data
                      widget.onAdding(
                        Exercise(
                          title: _textController.text,
                          duration: duration.toInt(),
                          isCompleted: isCompleted,
                          intensity: _selectedIntensity!,
                        ),
                      );

                      Navigator.of(context).pop();
                    },
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
