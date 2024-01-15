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
    int total,
    String colorName,
    Color color,
  ) {
    List<ColorData> colors = [...state.colorData];
    final newColor = ColorData(total: total, color: color, colorName: colorName);
    colors.add(newColor);
    emit(state.copyWith(colorData: colors));
  }

  void assessEmotions() {
    int sad = 1;
    int happy = 1;
    int stress = 1;
    int relaxed = 1;
    int anxious = 1;
    int calm = 1;
    int tired = 1;
    int energized = 1;
    int insecure = 1;
    int confident = 1;
    int pessimistic = 1;
    int optimistic = 1;
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
