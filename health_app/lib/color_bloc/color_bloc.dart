import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/color_bloc/color_state.dart';
import 'package:health_app/color_bloc/movement_logic.dart';

class ColorCubit extends Cubit<ColorState> {
  ColorCubit() : super(const ColorState());

  void updateColorInteraction(String color) {
    Map<String, int> colorInteractionCount = {...state.colorInteractionCount};
    if (colorInteractionCount.containsKey(color)) {
      colorInteractionCount[color] = colorInteractionCount[color]! + 1;
    } else {
      colorInteractionCount[color] = 1;
    }
    emit(state.copyWith(colorInteractionCount: colorInteractionCount));
  }

  void addStart() {
    int start = state.start + 1;
    emit(state.copyWith(start: start));
  }

  void addNewColor(
    // String start,
    // String end,
    int total,
    String colorName,
    Color color,
  ) {
    List<ColorData> colors = [...state.colorData];
    final newColor = ColorData(
        // start: start,
        // end: end,
        total: total,
        color: color,
        colorName: colorName);
    colors.add(newColor);
    emit(state.copyWith(colorData: colors));
  }

  // void aggregateAndSortColors() {
  //   // Step 1: Aggregate durations
  //   Map<Color, int> aggregatedDurations = {};
  //   for (final data in state.colorData) {
  //     if (data.total.isNotEmpty) {
  //       int duration = int.parse(data.total);
  //       if (aggregatedDurations.containsKey(data.color)) {
  //         aggregatedDurations[data.color] = aggregatedDurations[data.color]! + duration;
  //       } else {
  //         aggregatedDurations[data.color] = duration;
  //       }
  //     }
  //   }

  //   // Step 2: Convert map to list
  //   List<ColorData> aggregatedList = aggregatedDurations.entries.map((entry) {
  //     return ColorData(
  //       total: '${entry.value}',
  //       colorName: colorsMap[entry.key]!, // You may need to handle colorName differently
  //       color: entry.key,
  //     );
  //   }).toList();

  //   // Step 3: Sort the list
  //   aggregatedList.sort((a, b) => int.parse(b.total).compareTo(int.parse(a.total)));
  //   emit(state.copyWith(aggregatedData: aggregatedList));
  // }

  void assessEmotions() {
    int sad = 0;
    int happy = 0;
    int stress = 0;
    int relaxed = 0;
    int anxious = 0;
    int calm = 0;
    int tired = 0;
    int energized = 0;
    int insecure = 0;
    int confident = 0;
    int pessimistic = 0;
    int optimistic = 0;
    Set<String> totalColors = {};
    for (final cd in state.colorData) {
      totalColors.add(cd.colorName);
      final duration = cd.total;
      if (cd.colorName == 'blue') {
        sad += duration;
      }
      if (cd.colorName == 'yellow') {
        happy += duration;
      }
      if (cd.colorName == 'dark red') {
        stress += duration;
      }
      if (cd.colorName == 'light blue') {
        relaxed += duration;
      }
      if (cd.colorName == 'black') {
        anxious += duration;
      }
      if (cd.colorName == 'green') {
        calm += duration;
      }
      if (cd.colorName == 'purple') {
        tired += duration;
      }
      if (cd.colorName == 'orange') {
        energized += duration;
      }
      if (cd.colorName == 'light yellow') {
        insecure += duration;
      }
      if (cd.colorName == 'red') {
        confident += duration;
      }
      if (cd.colorName == 'dark blue') {
        pessimistic += duration;
      }
      if (cd.colorName == 'light green') {
        optimistic += duration;
      }
      // if (duration < 30) {
      //   anxious += 40;
      // }
      // if (duration < 55 && duration > 30) {
      //   stress += 40;
      // }
      // if (duration < 100 && duration > 55) {
      //   happy += 40;
      // }
      // if (duration > 150 && duration < 250) {
      //   calm += 40;
      // }
      // if (duration > 300 && duration < 400) {
      //   sad += 40;
      // }
      // if (duration > 400 && duration < 500) {
      //   relaxed += duration;
      // }
      // if (duration > 500) {
      //   relaxed += 40;
      // }
    }
    sad += sadMovements(state);
    happy += happyMovements(state);
    stress += stressedMovements(state);
    relaxed += relaxedMovements(state);
    anxious += anxiousMovements(totalColors, state);
    calm += calmMovements(state);
    tired += tiredMovements(totalColors, state);
    energized += energizedMovements(totalColors, state);
    insecure += insecureMovements(totalColors, state);
    confident += confidentMovements(totalColors, state);
    pessimistic += pessimisticMovements(totalColors);
    optimistic += optimisticMovements(totalColors, state);

    emit(
      state.copyWith(
        sad: sad,
        happy: happy,
        stressed: stress,
        relaxed: relaxed,
        anxious: anxious,
        calm: calm,
        tired: tired,
        energized: energized,
        insecure: insecure,
        confident: confident,
        pessimistic: pessimistic,
        optimistic: optimistic,
      ),
    );
  }
}
