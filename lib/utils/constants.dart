import 'package:flutter/material.dart';
import 'package:workout_plan/models/exercise.dart';

/// Defines the light theme color scheme for the app.
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 28, 60, 95),
);

/// Defines the dark theme color scheme for the app.
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 23, 27),
);

/// Maps exercise intensity levels to their respective colors.
const Map<Intensity, Color> intensityColors = {
  Intensity.low: Colors.green,
  Intensity.medium: Colors.yellow,
  Intensity.high: Colors.red,
};

/// Default elevation for cards used throughout the app.
const double kCardElevation = 2.0;

/// Default border radius for cards and containers.
const double kCardBorderRadius = 12.0;

/// Standard padding used across widgets for consistent spacing.
const EdgeInsets kPaddingAll = EdgeInsets.all(16.0);
