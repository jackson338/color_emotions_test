import 'package:flutter/material.dart';
import 'package:health_app/color_test.dart';
import 'package:health_app/instructions_view.dart';

void main() => runApp(const MaterialApp(home: RbeatApp()));

class RbeatApp extends StatelessWidget {
  const RbeatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2D2D2),
      body: SafeArea(
        child: Column(
          children: [
            TitleBar(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Text(
                        'Thank you for participating! This is a unique test designed evaluate emotional status based on colors, sounds and movements.',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                      child: Text(
                        'This is a prototype designed to validate the concept and your feedback is essential. Thank you for participating!',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InstructionsView(),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 9.0,
                      horizontal: 27.0,
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Text(
                        'When you are ready press Start.',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
                      child: Text(
                        'Once you start, move your finger around the colors however you FEEL for 10 seconds. Then review the assessment and provide feedback.',
                        style: TextStyle(
                          fontSize: 16,
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
      ),
    );
  }
}

class TitleBar extends StatelessWidget {
  const TitleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.zero,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                //Colors.red,
                //Colors.orange,
                //Colors.yellow,
                //Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
              ],
            )),
        child: const Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Color Emotions Test',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
