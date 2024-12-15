import 'package:flutter/material.dart';
import 'package:workout_plan/widgets/exercise_mainscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_plan/utils/constants.dart';

/// The main function initializes and starts the application.
void main() {
  /// Ensures that the Flutter binding is initialized before running the app.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      /// Sets the main screen to ExerciseMainScreen.
      home: const ExerciseMainScreen(),

      /// Configures the light theme and global styles.
      theme: ThemeData().copyWith(
        /// Applies a predefined color scheme from constants.
        colorScheme: kColorScheme,

        /// Sets the text theme to use the Inter font.
        textTheme: GoogleFonts.interTextTheme(),

        /// Customizes the AppBar theme.
        appBarTheme: AppBarTheme(
          backgroundColor:
              kColorScheme.primaryContainer, // Background color of the AppBar.
          foregroundColor:
              kColorScheme.onPrimaryContainer, // Text color for the AppBar.
          titleTextStyle: GoogleFonts.inter(
            fontSize: 18, // Sets the font size.
            fontWeight: FontWeight.bold, // Makes the title bold.
          ),
        ),

        /// Configures the theme for elevated buttons.
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                kColorScheme.primary, // Background color of the button.
            foregroundColor:
                kColorScheme.onPrimary, // Text color of the button.
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(12), // Applies rounded corners.
            ),
          ),
        ),
      ),

      /// Configures the dark theme using a predefined color scheme.
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
      ),
    ),
  );
}
