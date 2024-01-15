import 'package:flutter/material.dart';

class ColorState {
  final List<ColorData> colorData;
  final List<ColorData> aggregatedData;
  final int sad;
  final int happy;
  final int stressed;
  final int relaxed;
  final int anxious;
  final int calm;
  final int tired;
  final int energized;
  final int insecure;
  final int confident;
  final int pessimistic;
  final int optimistic;
  final Map<String, int> colorInteractionCount;
  final int start;

  const ColorState({
    this.colorData = const [ColorData.empty()],
    this.aggregatedData = const [ColorData.empty()],
    this.sad = 1,
    this.happy = 1,
    this.stressed = 1,
    this.relaxed = 1,
    this.anxious = 1,
    this.calm = 1,
    this.tired = 1,
    this.energized = 1,
    this.insecure = 1,
    this.confident = 1,
    this.pessimistic = 1,
    this.optimistic = 1,
    this.colorInteractionCount = const {},
    this.start = 0,
  });

  ColorState copyWith({
    final List<ColorData>? colorData,
    final List<ColorData>? aggregatedData,
    final int? sad,
    final int? happy,
    final int? stressed,
    final int? relaxed,
    final int? anxious,
    final int? calm,
    final int? tired,
    final int? energized,
    final int? insecure,
    final int? confident,
    final int? pessimistic,
    final int? optimistic,
    final Map<String, int>? colorInteractionCount,
    final int? start,
  }) {
    return ColorState(
      colorData: colorData ?? this.colorData,
      aggregatedData: aggregatedData ?? this.aggregatedData,
      sad: sad ?? this.sad,
      happy: happy ?? this.happy,
      stressed: stressed ?? this.stressed,
      relaxed: relaxed ?? this.relaxed,
      anxious: anxious ?? this.anxious,
      calm: calm ?? this.calm,
      tired: tired ?? this.tired,
      energized: energized ?? this.energized,
      insecure: insecure ?? this.insecure,
      confident: confident ?? this.confident,
      pessimistic: pessimistic ?? this.pessimistic,
      optimistic: optimistic ?? this.optimistic,
      colorInteractionCount: colorInteractionCount ?? this.colorInteractionCount,
      start: start ?? this.start,
    );
  }
}

class ColorData {
  const ColorData({
    required this.total,
    required this.colorName,
    required this.color,
  });
  final int total;
  final String colorName;
  final Color color;

  const ColorData.empty({
    this.total = 0,
    this.colorName = '',
    this.color = const Color(0xFF2A4361),
  });
}

Map<Color, String> colorsMap = {
  Colors.blue.shade300: "light blue",
  Colors.blue.shade700: "blue",
  Colors.blue[900]!: "dark blue",
  Colors.yellow.shade200: "light yellow",
  Colors.yellow.shade500: "yellow",
  Colors.orange: "orange",
  Colors.red: "red",
  Colors.red.shade900: "dark red",
  Colors.purple: "purple",
  Colors.green: "light green",
  Colors.green.shade800: "green",
  const Color(0xFF454545): "black",
};

class Emotions {
  final int depression;
  final int anxiety;
  final int calm;
  final int happy;
  final int excitement;
  final int anger;
  const Emotions({
    required this.depression,
    required this.anxiety,
    required this.calm,
    required this.happy,
    required this.excitement,
    required this.anger,
  });
}
