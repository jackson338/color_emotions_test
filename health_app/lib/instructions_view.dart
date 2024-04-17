import 'package:flutter/material.dart';
import 'package:health_app/color_test.dart';
//import 'package:health_app/main.dart';

class InstructionsView extends StatefulWidget {
  const InstructionsView({super.key});

  @override
  State<InstructionsView> createState() => _InstructionsViewState();
}

class _InstructionsViewState extends State<InstructionsView> {
  final List<Color> backgroundGradientColors = [
    const Color.fromARGB(221, 230, 230, 230),
    Colors.white,
    const Color.fromARGB(221, 230, 230, 230),
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CETview(),
            ));
      }
      if (currentState == instructionTitles.length - 1) {
        currentButtonText = 'Start';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: backgroundGradientColors,
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              //for (final title in instructionTitles)
              //{
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(instructionTitles[currentState],
                    style: const TextStyle(fontSize: 24.0)),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Text(instructionBodies[currentState],
                    style: const TextStyle(fontSize: 18.0)),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                    onPressed: onNextPressed, child: Text(currentButtonText)),
              ),
              //}
            ],
          ),
        ),
      ),
    ));
  }
}
