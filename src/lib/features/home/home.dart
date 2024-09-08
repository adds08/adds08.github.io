import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:src/components/spacing.dart';
import 'package:src/consts.dart';
import 'package:src/features/about/about.dart';
import 'package:typewritertext/typewritertext.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int textIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            if (textIndex >= 0) ...[
              TypeWriter.text(
                'Hi this is Atish Shakya!',
                duration: textTypingAnimationDuration,
                softWrap: false,
                maintainSize: false,
                onFinished: (value) {
                  setState(() {
                    textIndex++;
                  });
                },
              ),
            ] else
              const Text(""),
            const VSpacing(),
            if (textIndex >= 1) ...[
              TypeWriter.text(
                'Welcome to my website',
                duration: textTypingAnimationDuration,
                softWrap: false,
                maintainSize: false,
                onFinished: (value) {
                  setState(() {
                    textIndex++;
                  });
                },
              ),
            ] else
              const Text(""),
            const VSpacing(),
            if (textIndex >= 2) ...[
              TypeWriter.text(
                'To know more about me',
                duration: textTypingAnimationDuration,
                softWrap: false,
                maintainSize: false,
                onFinished: (value) {
                  setState(() {
                    textIndex++;
                  });
                },
              ),
            ] else
              const Text(""),
            const VSpacing(),
            NesButton(
              type: NesButtonType.normal,
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutMePage())),
              child: (textIndex >= 3)
                  ? TypeWriter.text(
                      'Click Here!',
                      duration: textTypingAnimationDuration,
                      softWrap: false,
                      maintainSize: false,
                    )
                  : const Text(""),
            ).animate().fadeIn(
                  delay: (textIndex >= 3) ? 0.ms : 1.minutes,
                  duration: textTypingAnimationDuration,
                )
          ],
        ),
      ),
    );
  }
}
