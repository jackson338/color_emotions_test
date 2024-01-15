import 'package:flutter/material.dart';
import 'package:health_app/color_bloc/color_bloc.dart';

class ResultsView extends StatelessWidget {
  final ColorCubit cc;
  const ResultsView({
    super.key,
    required this.cc,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          backgroundColor: const Color(0xFFD2D2D2),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: ListView(
                      children: [
                        EmotionScale(
                          title1: 'Sad',
                          title2: 'Happy',
                          total: cc.state.happy - cc.state.sad,
                          max: cc.state.happy > cc.state.sad
                              ? cc.state.happy
                              : cc.state.sad,
                        ),
                        EmotionScale(
                          title1: 'Stressed',
                          title2: 'Relaxed',
                          total: cc.state.relaxed - cc.state.stressed,
                          max: cc.state.relaxed > cc.state.stressed
                              ? cc.state.relaxed
                              : cc.state.stressed,
                        ),
                        EmotionScale(
                          title1: 'Anxious',
                          title2: 'Calm',
                          total: cc.state.calm - cc.state.anxious,
                          max: cc.state.calm > cc.state.anxious
                              ? cc.state.calm
                              : cc.state.anxious,
                        ),
                        EmotionScale(
                          title1: 'Tired',
                          title2: 'Energized',
                          total: cc.state.energized - cc.state.tired,
                          max: cc.state.energized > cc.state.tired
                              ? cc.state.energized
                              : cc.state.tired,
                        ),
                        EmotionScale(
                          title1: 'Insecure',
                          title2: 'Confident',
                          total: cc.state.confident - cc.state.insecure,
                          max: cc.state.confident > cc.state.insecure
                              ? cc.state.confident
                              : cc.state.insecure,
                        ),
                        EmotionScale(
                          title1: 'Pessimistic',
                          title2: 'Optimistic',
                          total: cc.state.optimistic - cc.state.pessimistic,
                          max: cc.state.optimistic > cc.state.pessimistic
                              ? cc.state.optimistic
                              : cc.state.pessimistic,
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[800],
                        ),
                        child: Center(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Home',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class EmotionScale extends StatelessWidget {
  final String title1;
  final String title2;
  final int total;
  final int max;
  const EmotionScale({
    super.key,
    required this.title1,
    required this.title2,
    required this.total,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final min = -max;
    final double percentage = (total - min) / (max - min);
    double viewingPercentage = (total / max) * 100;
    late int vp;
    print('viewingPercentage: $viewingPercentage');
    if (viewingPercentage != 0) {
      vp = viewingPercentage.round();
    } else {
      vp = 0;
    }
    return InkWell(
      onTap: () => showDetailsSheet(
        context: context,
        title1: title1,
        title2: title2,
        percentage: percentage,
        vp: vp,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title1,
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      title2,
                      style: const TextStyle(
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 20,
                  child: CustomPaint(
                    painter: _ProgressBarPainter(percentage),
                  ),
                ),
                Text(
                  "$vp%",
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProgressBarPainter extends CustomPainter {
  final double normalizedValue;

  _ProgressBarPainter(this.normalizedValue);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // Draw background
    canvas.drawRect(Offset.zero & size, paint);

    // Adjust for negative values
    double progressWidth;
    if (normalizedValue < 0.5) {
      // Negative value
      paint.color = Colors.red;
      progressWidth = (0.5 - normalizedValue) * size.width;
      canvas.drawRect(
          Offset(size.width / 2 - progressWidth, 0) & Size(progressWidth, size.height),
          paint);
    } else {
      // Positive value
      paint.color = Colors.green;
      progressWidth = (normalizedValue - 0.5) * size.width;
      canvas.drawRect(
          Offset(size.width / 2, 0) & Size(progressWidth, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void showDetailsSheet({
  required BuildContext context,
  required String title1,
  required String title2,
  required double percentage,
  required int vp,
}) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.75, // 75% of screen height
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 20,
                  child: CustomPaint(
                    painter: _ProgressBarPainter(percentage),
                  ),
                ),
                Text(
                  "$vp%",
                  style: const TextStyle(
                    fontSize: 22,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                title1,
                                style: const TextStyle(
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Text(
                                emotionDetails[title1]!,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                title2,
                                style: const TextStyle(
                                  fontSize: 26,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Text(
                                emotionDetails[title2]!,
                                textAlign: TextAlign.center,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Map<String, String> emotionDetails = {
  'Sad':
      "Feeling down or unhappy in response to grief, disappointment, or other challenging circumstances. It's a natural human emotion involving a temporary decrease in one's mood and energy.",
  'Happy':
      "A state of joy and contentment, where one feels a sense of fulfillment, pleasure, or positive enjoyment. It's often accompanied by a sense of confidence in one's situation or future.",
  'Stressed':
      "Stress is typically a response to an external trigger and is often associated with high pressure, urgent demands, or other immediate challenges. It can manifest as a feeling of being overwhelmed or unable to cope with specific demands. Stress is usually short-term and directly related to the pressure of a situation or event. For instance, you might feel stressed when facing a tight deadline or during a busy workday.",
  'Relaxed':
      "Relaxed refers to a state of physical ease and freedom from tension or strain. It is often experienced as a release or relief from stress and anxiety. Being relaxed is associated with a sense of comfort, restfulness, and leisure. It's a state where one's mind and body are at ease, often following the removal or absence of stressors. For instance, one might feel relaxed while lounging on a beach, enjoying a quiet hobby, or after completing a demanding task. It's a state of restorative tranquility, often accompanied by a sense of satisfaction or contentment.",
  'Anxious':
      "Anxiety, while it can be triggered by stress, is characterized more by persistent, excessive worries that might not have a specific source or may continue even after a stressor is gone. It's often related to anticipation of future events, with a focus on negative outcomes. Anxiety can linger as a sustained emotional state and can manifest even in the absence of immediate external pressures. For example, you might feel anxious about an upcoming event, even when there's no immediate threat or pressure.",
  'Calm':
      "Calm denotes a state of serenity and stability, characterized by the absence of agitation, excitement, or disturbance. It implies a composed, collected demeanor and an ability to remain untroubled and steady, even in potentially stressful situations. Being calm is about maintaining emotional control and a clear, peaceful state of mind. It's often related to a long-term character trait or an approach to life, rather than a temporary state. For example, a person might remain calm during a crisis, showing an ability to think clearly and react appropriately without succumbing to stress.",
  'Tired':
      "Feeling a need for rest or sleep. Tiredness can result from physical exertion, lack of sleep, or mental fatigue and often leads to a decrease in energy and motivation.",
  'Energized':
      "Feeling lively, full of energy, and ready for action. This state is often marked by increased physical and mental activity, enthusiasm, and a feeling of being recharged or invigorated.",
  'Insecure':
      "Experiencing self-doubt and a lack of confidence or assurance. Insecurity can involve feelings of uncertainty about oneself or one's abilities, often leading to hesitation and apprehension.",
  'Confident':
      "Feeling self-assured and trusting in one's abilities, qualities, and judgment. Confidence is characterized by a positive view of oneself and one's capabilities.",
  'Pessimistic':
      "Tending to see the worst aspect of things or believe that the worst will happen. Pessimism involves a general lack of hope or belief that positive outcomes will occur.",
  'Optimistic':
      "Expecting the best in the future and focusing on the good aspects of any situation. Optimism is characterized by hopefulness and a belief that good things will happen.",
};
