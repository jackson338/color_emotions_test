import 'package:flutter/material.dart';
//import 'package:health_app/main.dart';

class InstructionsView extends StatefulWidget {
  InstructionsView({super.key});

  @override
  State<InstructionsView> createState() => _InstructionsViewState();
}

class _InstructionsViewState extends State<InstructionsView> {
  final List<Color> backgroundGradientColors = [
    Color.fromARGB(221, 230, 230, 230),
    Colors.white,
    Color.fromARGB(221, 230, 230, 230)
  ];
  final List<String> instructionTitles = [
    'What is the Color Test?',
    'Why is it free?',
    'How does it work?',
  ];
  final List<String> instructionBodies = [
    'This is a unique test designed evaluate emotional status based on colors, sounds and movements.',
    'The color test was created in an effort to study the validity and scientific value of the influence that colors can have on our emotions. This is a prototype designed to validate the concept and your feedback is essential. We would like to find ways this can be implemented for mental health in business environments and others. We are anonymously collecting data produced in these tests in order to back the theory and to realize our dream of real world use of a potentially powerful tool. Thank you for participating!',
    'Once you start move your finger around the colors however you FEEL for 10 seconds. Then review the assessment and provide feedback. When you are ready press Start.',
  ];
  int currentState = 0;
  String currentButtonText = 'Next';

  void onNextPressed() {
    setState(() {
      if (currentState != instructionTitles.length - 1) {
        currentState += 1;
      } else {
        //Start the color test.
      }
      if (currentState == instructionTitles.length - 1) {
        currentButtonText = 'Start';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: backgroundGradientColors,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              //for (final title in instructionTitles)
              //{
              Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(instructionTitles[currentState],
                    style: TextStyle(fontSize: 24.0)),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(32.0),
                child: Text(instructionBodies[currentState],
                    style: TextStyle(fontSize: 18.0)),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.all(32.0),
                child: ElevatedButton(
                    onPressed: onNextPressed, child: Text(currentButtonText)),
              ),
              //}
            ],
          ),
        ),
      ),
    )));
  }
}
