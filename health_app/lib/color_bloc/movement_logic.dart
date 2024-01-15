import 'package:health_app/color_bloc/color_state.dart';

int smallDuration() {
  return 100;
}

int mediumDuration() {
  return 200;
}

int largeDuration() {
  return 400;
}

int sadMovements(ColorState state) {
  int sad = 0;
  int avgDuration = 0;

  // If all colors have few encounters this is indicative of sadness.
  int maxEncounters = 0;
  state.colorInteractionCount.forEach((key, value) {
    if (value > maxEncounters) {
      maxEncounters = value;
    }
  });
  // Slow average movement is indicative of Sadness.
  for (final cd in state.colorData) {
    avgDuration += cd.total;
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration > 250) {
    print('Sad: avgDuration: $avgDuration');
    sad += mediumDuration();
  }
  if (maxEncounters >= 3 && avgDuration > 250) {
    print('Sad: maxEncounters >= 3 && avgDuration > 250: $avgDuration');
    sad += mediumDuration();
  }

  // slow movements and few interactions is indicative of Sadness.
  if (state.colorData.length < 30) {
    print('Sad: colorData.length < 30: ${state.colorData.length}');
    sad += mediumDuration();
  }
  return sad;
}

int happyMovements(ColorState state) {
  int happy = 0;
  int avgDuration = 0;

// A faster average duration is indicative of Happiness.
  for (final cd in state.colorData) {
    avgDuration += cd.total;
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration < 250) {
    print('Happy: avgDuration: $avgDuration');
    happy += mediumDuration();
  }
  // if many colors are interacted with often this indicates Happiness.
  if (state.colorData.length > 40) {
    print('Happy: colorData.length > 40: ${state.colorData.length}');
    happy += mediumDuration();
  }
  // consistent interactions with few colors is indicative of happy.
  var sortedEntries = state.colorInteractionCount.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  if (sortedEntries[4].value < sortedEntries[3].value - 4 ||
      sortedEntries[2].value < sortedEntries[3].value - 4) {
    print(
        'Happy: top 5 sorted entries are greater than 6th runner up by 4 or more interactions');
    happy += mediumDuration();
  }

  return happy;
}

int stressedMovements(ColorState state) {
  int stressed = 0;
  int small = state.colorData[0].total;
  int large = state.colorData[0].total;
  // changes in speed is indicative of stress.
  int prevDuration = 0;
  // a large gap between movement speeds is indicative of Stress.
  for (final cd in state.colorData) {
    if (cd.total - prevDuration < -440 || cd.total - prevDuration > 440) {
      print('Stressed: Speed Change: ${cd.total - prevDuration}');
      stressed += smallDuration() ~/ 3;
    }
    if (cd.total < small) {
      small = cd.total;
    }
    if (cd.total > large) {
      large = cd.total;
    }
    prevDuration = cd.total;
  }
  if (large - small > 1000) {
    print('Stressed: large - small > 1200: ${large - small}');
    stressed += smallDuration() ~/ 2;
  }
  // quick movements is indicative of Stress.
  int avgDuration = 0;
  for (final cd in state.colorData) {
    avgDuration += cd.total;
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration < 120) {
    print('Stressed: $avgDuration < 90');
    stressed += smallDuration();
  }
  return stressed;
}

int relaxedMovements(ColorState state) {
  int relaxed = 0;
  // a steady and consistent pace is indicative of relaxed.
  int small = state.colorData[0].total;
  int large = state.colorData[0].total;
  int avgDuration = 0;
  for (final cd in state.colorData) {
    avgDuration += cd.total;
    if (cd.total < small) {
      small = cd.total;
    }
    if (cd.total > large) {
      large = cd.total;
    }
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (large - small < 600 && avgDuration > 140) {
    print(
        'Relaxed: large - small < 600: ${large - small} && avgDuration < 140: $avgDuration');
    relaxed += mediumDuration();
  }
  // smooth, steady movements with consistent pace and direction is indicative of relaxation.
  int qualifying = 0;
  int diff = 0;
  int prevVal = state.colorInteractionCount.values.first;
  state.colorInteractionCount.forEach((key, value) {
    if (prevVal >= value + 2) {
      diff += 1;
    }
    prevVal = value;
    if (value >= 2 && value <= 4) {
      qualifying += 1;
    }
  });
  if (diff < state.colorInteractionCount.length ~/ 2) {
    print(
        'Relaxed: diff < state.colorInteractionCount.length ~/ 2: $diff < ${state.colorInteractionCount.length ~/ 2}');
    relaxed += smallDuration();
  }
  if (state.colorInteractionCount.length > 3) {
    if (qualifying >= state.colorInteractionCount.length - 3) {
      print(
          'Relaxed: qualifying >= state.colorInteractionCount.length - 3: $qualifying >= ${state.colorInteractionCount.length - 3}');
      relaxed += smallDuration();
    }
  }
  return relaxed;
}

int anxiousMovements(
  Set totalColors,
  ColorState state,
) {
  int anxious = 0;
  int totalInteraction = 0;
  state.colorInteractionCount.forEach((color, count) {
    totalInteraction += count;
    if (count > 5) {
      print('Anxious: count > 5: $count');
      anxious += smallDuration() ~/ 2;
    } else if (count > 7) {
      print('Anxious: count > 7: $count');
      anxious += smallDuration();
    }
  });
  if (totalInteraction > 42) {
    print('Anxious: totalInteraction > 38: $totalInteraction');
    anxious += smallDuration();
  }
  if (totalColors.length < 8) {
    print('Anxious: Confined to small area');
    anxious += smallDuration();
  }
  int avgDuration = 0;
  for (final cd in state.colorData) {
    avgDuration += cd.total;
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration < 140) {
    print('Anxious: avgDuration < 140: $avgDuration');
    anxious += mediumDuration();
  }
  if (state.start > 6) {
    print('Anxious: start > 6: ${state.start}');
    anxious += mediumDuration();
  }
  return anxious;
}

int calmMovements(ColorState state) {
  int calm = 0;
  int small = state.colorData[0].total;
  int large = state.colorData[0].total;
  int avgDuration = 0;
  for (final cd in state.colorData) {
    avgDuration += cd.total;
    if (cd.total < small) {
      small = cd.total;
    }
    if (cd.total > large) {
      large = cd.total;
    }
  }
  if (large - small < 700 && avgDuration > 140) {
    print(
        'Calm: large - small < 700: ${large - small} && avgDuration > 140: $avgDuration');
    calm += smallDuration();
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration > 140 && avgDuration < 350) {
    print('Calm: avgDuration > 140 && < 350: $avgDuration');
    calm += smallDuration();
  }

  int qualifying = 0;
  state.colorInteractionCount.forEach((key, value) {
    if (value > 1 && value < 4) {
      qualifying += 1;
    }
  });
  if (qualifying >= state.colorInteractionCount.length - 1) {
    print(
        'Calm: qualifying >= state.colorInteractionCount.length - 1: $qualifying >= ${state.colorInteractionCount.length - 1}');
    calm += smallDuration();
  }

  return calm;
}

int tiredMovements(
  Set totalColors,
  ColorState state,
) {
  int tired = 0;
  if (totalColors.length < 9) {
    print('Tired: totalColors.length < 9: ${totalColors.length}');
    tired += smallDuration();
  }
  int avgDuration = 0;
  for (final cd in state.colorData) {
    avgDuration += cd.total;
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration > 350) {
    print('Tired: avgDuration > 350 : $avgDuration');
    tired += mediumDuration();
  }
  if (state.colorData.length < 34) {
    print('Tired: state.colorData.length < 34: ${state.colorData.length}');
    tired += smallDuration();
  }
  return tired;
}

int energizedMovements(
  Set totalColors,
  ColorState state,
) {
  int energized = 0;
  if (totalColors.length > 8) {
    energized += smallDuration();
  }
  int avgDuration = 0;
  for (final cd in state.colorData) {
    avgDuration += cd.total;
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration > 75 && avgDuration < 140) {
    energized += mediumDuration();
  }
  return energized;
}

int optimisticMovements(
  Set totalColors,
  ColorState state,
) {
  int optimistic = 0;
  if (totalColors.length > 8) {
    optimistic += mediumDuration();
  }
  if (state.colorData.length > 25) {
    optimistic += smallDuration();
  }
  if (state.colorData.length > 35) {
    optimistic += smallDuration();
  }
  return optimistic;
}

int pessimisticMovements(Set totalColors) {
  int pessimistic = 0;
  if (totalColors.length < 6) {
    pessimistic += largeDuration();
  }
  return pessimistic;
}

int confidentMovements(
  Set totalColors,
  ColorState state,
) {
  int confident = 0;

  if (totalColors.length > 11) {
    confident += mediumDuration();
  }
  int avgDuration = 0;
  for (final cd in state.colorData) {
    avgDuration += cd.total;
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration < 260 && avgDuration > 180) {
    confident += mediumDuration();
  }
  return confident;
}

int insecureMovements(
  Set totalColors,
  ColorState state,
) {
  int insecure = 0;

  if (totalColors.length < 5) {
    insecure += smallDuration();
  }
  int avgDuration = 0;
  for (final cd in state.colorData) {
    avgDuration += cd.total;
  }
  avgDuration = avgDuration ~/ state.colorData.length;
  if (avgDuration > 325) {
    insecure += mediumDuration();
  }
  return insecure;
}
