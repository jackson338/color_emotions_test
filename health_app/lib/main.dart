import 'package:flutter/material.dart';

import 'package:health_app/instructions_view.dart';

void main() => runApp(MaterialApp(
      home: RbeatApp(),
      debugShowCheckedModeBanner: false,
    ));

class RbeatApp extends StatelessWidget {
  RbeatApp({super.key});

  final gradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ],
  );

  final textStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      BoxShadow(
        color: Colors.white,
        spreadRadius: 5,
        offset: Offset(1, 1),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2D2D2),
      body: Column(
        children: [
          const TitleBar(),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InstructionsView(),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9.0,
                    horizontal: 27.0,
                  ),
                  child: ShaderMask(
                    shaderCallback: (bounds) {
                      return gradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      );
                    },
                    child: Text(
                      'Begin',
                      style: textStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 42.0),
                  child: Text(
                    'This is a unique test designed to evaluate emotional status based on colors, sounds and movements. Thank you for participating!',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
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
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: const BoxDecoration(
            // borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(8.0),
            //     bottomRight: Radius.circular(8.0)),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 1,
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
