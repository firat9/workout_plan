import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_plan/models/exercise.dart';
import 'package:workout_plan/widgets/exercise_mainscreen.dart';

void main() {
  testWidgets('Add a new exercise and verify it appears',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MaterialApp(home: ExerciseMainScreen()));

    // Tap the "+" button to open the bottom sheet
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Enter exercise details
    await tester.enterText(find.byType(TextField).at(0), 'Test Exercise');
    await tester.enterText(find.byType(TextField).at(1), '10');
    await tester.tap(find.byType(DropdownButtonFormField<Intensity>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('MEDIUM').last);
    await tester.pumpAndSettle();

    // Tap the "Save" button
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the new exercise appears in the list
    expect(find.text('Test Exercise'), findsOneWidget);
    expect(find.text('10 mins - medium'), findsOneWidget);
  });

  testWidgets('Delete an exercise from the list', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MaterialApp(home: ExerciseMainScreen()));

    // Add an exercise first
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Exercise to Delete');
    await tester.enterText(find.byType(TextField).at(1), '5');
    await tester.tap(find.byType(DropdownButtonFormField<Intensity>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('LOW').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify the exercise is added
    expect(find.text('Exercise to Delete'), findsOneWidget);

    // Swipe to delete the exercise
    await tester.drag(find.text('Exercise to Delete'), const Offset(-500, 0));
    await tester.pumpAndSettle(); // Animasyonların bitmesini bekle

    // Verify the exercise is deleted
    expect(find.text('Exercise to Delete'), findsNothing);
  });
}
