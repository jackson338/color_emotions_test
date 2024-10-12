import 'package:flutter/material.dart';

class InsufficientDataView extends StatelessWidget {
  const InsufficientDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD2D2D2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD2D2D2),
        title: Text('Not Enough Data'),
        leading: GestureDetector(
          onTap: () => Navigator.of(context)
            ..pop()
            ..pop(),
          child: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
                'We require a certain amount of data to calculate your results. Unfortunately, you did not interact with the color grid enough for us to make an assessment. Please try again.'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.of(context)
                  ..pop()
                  ..pop()
                  ..pop(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Go Home'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
