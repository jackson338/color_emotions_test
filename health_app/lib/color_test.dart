import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/insufficient_data_view.dart';
import 'package:health_app/results_view.dart';
import './color_bloc/export.dart';
import 'dart:math' as math;

class CETview extends StatefulWidget {
  const CETview({super.key});

  @override
  State<CETview> createState() => _CETviewState();
}

class _CETviewState extends State<CETview> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Scaffold(
            body: SafeArea(
              child: BlocProvider(
                create: (context) => ColorCubit(),
                child: BlocBuilder<ColorCubit, ColorState>(
                  builder: (context, state) {
                    final cc = context.read<ColorCubit>();
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (tapped)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: SizedBox(
                              width: 130,
                              height: 130,
                              child: TweenAnimationBuilder<double>(
                                duration: const Duration(seconds: 10),
                                onEnd: () {
                                  try {
                                    cc.assessEmotions();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ResultsView(
                                                  cc: cc,
                                                )));
                                  } catch (e) {
                                    print(e);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const InsufficientDataView()));
                                  }
                                },
                                tween: Tween(
                                  begin: 0.0,
                                  end: 1.0,
                                ),
                                builder: (context, progress, child) {
                                  return CustomPaint(
                                    painter: CircleProgressPainter(
                                      progress,
                                      Colors.grey[800]!,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 50),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xFF2A4361),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 9),
                              child: ColorTrackingCanvas(
                                cc: cc,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          if (!tapped)
            GestureDetector(
              onTap: () => setState(() {
                tapped = true;
              }),
              child: Container(
                color: Colors.black.withOpacity(0.7),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Tap Anywhere to begin',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Then place your finger ON the color grid and move it around however you feel.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ColorTrackingCanvas extends StatefulWidget {
  final ColorCubit cc;
  const ColorTrackingCanvas({
    super.key,
    required this.cc,
  });

  @override
  ColorTrackingCanvasState createState() => ColorTrackingCanvasState();
}

class ColorTrackingCanvasState extends State<ColorTrackingCanvas> {
  Map<Color, Duration> colorDuration = {};
  Color currentColor = Colors.transparent;
  Stopwatch stopwatch = Stopwatch();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.cc.addStart(),
      onPanStart: (details) {
        _updateCurrentColor(details.localPosition, widget.cc);
        stopwatch.reset();
        stopwatch.start();
      },
      onPanUpdate: (details) {
        _updateCurrentColor(details.localPosition, widget.cc);
      },
      onPanEnd: (details) {
        stopwatch.stop();
        _updateDuration(currentColor, stopwatch.elapsed);
      },
      child: CustomPaint(
        painter: ColorGridPainter(),
        child: Container(),
      ),
    );
  }

  void _updateCurrentColor(
    Offset position,
    ColorCubit cc,
  ) {
    int rows = 4;
    int columns = 3;
    double squareWidth = context.size!.width / columns;
    double squareHeight = context.size!.height / rows;

    // Calculate the row and column
    int row = (position.dy / squareHeight).floor();
    int column = (position.dx / squareWidth).floor();

    // Determine the color based on the row and column
    Color newColor = ColorGridPainter.getColorForPosition(
      row,
      column,
      colorsMap.keys.toList(),
    );

    // Update the duration if the color has changed
    if (currentColor != newColor) {
      stopwatch.stop();

      cc.updateColorInteraction(colorsMap[newColor]!);

      cc.addNewColor(
        stopwatch.elapsed.inMilliseconds,
        colorsMap[newColor]!,
        newColor,
      );
      _updateDuration(currentColor, stopwatch.elapsed);
      stopwatch.reset();
      stopwatch.start();
      currentColor = newColor;
    }
  }

  void _updateDuration(Color color, Duration duration) {
    if (color != Colors.transparent) {
      colorDuration.update(color, (existingDuration) => existingDuration + duration,
          ifAbsent: () => duration);
    }
  }
}

class ColorGridPainter extends CustomPainter {
  // ... (same as before) ...

  static Color getColorForPosition(int row, int column, List colors) {
    int index = row * 3 + column;

    return colors[index % colors.length];
  }

  @override
  void paint(Canvas canvas, Size size) {
    int rows = 4; // Number of rows in the grid
    int columns = 3; // Number of columns in the grid
    double squareWidth = size.width / columns;
    double squareHeight = size.height / rows;

    // Paint each square
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        int colorIndex = (row * columns + col) % colorsMap.keys.length;
        _paintSquare(canvas, Offset(col * squareWidth, row * squareHeight), squareWidth,
            squareHeight, colorsMap.keys.toList()[colorIndex]);
      }
    }
  }

  void _paintSquare(
      Canvas canvas, Offset offset, double width, double height, Color color) {
    Rect rect = offset & Size(width - 8, height - 8);
    canvas.drawRect(
      rect,
      Paint()
        ..color = color
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          convertRadiusToSigma(1.0),
        ),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

double convertRadiusToSigma(double radius) {
  return radius * 0.57735 + 0.5;
}

class CircleProgressPainter extends CustomPainter {
  final double progressRatio;
  final Color paintColor;

  CircleProgressPainter(
    this.progressRatio,
    this.paintColor,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = paintColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    // Draw the progressing border
    double startAngle = -math.pi / 2; // Starting from the top
    double sweepAngle = math.pi * 2 * progressRatio;
    canvas.drawArc(Offset.zero & size, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
