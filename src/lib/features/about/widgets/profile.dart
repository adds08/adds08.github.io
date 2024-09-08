import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:rive/rive.dart';
import 'package:src/features/about/components/stats_widget.dart';
import 'package:src/components/spacing.dart';
import 'package:src/consts.dart';
import 'package:typewritertext/typewritertext.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool riveAssetLoaded = false;
  bool? isMoveRight;
  late final StateMachineController? _controller;
  SMITrigger? _bump;

  @override
  void initState() {
    super.initState();
    isMoveRight = null;
  }

  void _onRiveInit(Artboard artboard) {
    _controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(_controller!);
    Timer.periodic(5.seconds, (time) {
      if (isMoveRight == null) {
        print(isMoveRight);
        _bump = _controller.getTriggerInput('stopHi');
        _bump?.fire();
        _bump = _controller.getTriggerInput('stop');
        _bump?.fire();
      }
    });
  }

  void _hitBump() {
    if (isMoveRight == null) {
      _bump = _controller!.getTriggerInput('stop');
      _bump?.fire();
      return;
    }

    if (!isMoveRight!) {
      _bump = _controller!.getTriggerInput('moveLeft');
      _bump?.fire();
    } else {
      _bump = _controller!.getTriggerInput('moveRight');
      _bump?.fire();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: TypeWriter.text(
                    "Hey, I’m Atish Shakya, a full-stack developer with a background in computer engineering and an MSIT. \n\nI started with C++ and Java, later moving to Node.js for backend and Flutter for frontend. I’ve worked in industries like construction, logistics, and POS systems, using tools like WebSockets and RDS. \n\nRecently, I’ve been focused on Next.js, React Native, Flutter, and Supabase. \n\nI’m also into deep learning, game dev, robotics, and AI as hobbies, with a keen interest in quantum mechanics.",
                    duration: textTypingAnimationDuration,
                    style: const TextStyle(height: 2.25),
                  ),
                ),
                const Expanded(
                    child: NesContainer(
                  label: "Stats",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatsWidget(statsName: "HP", statsMax: 200, color: Colors.red),
                            VSpacing(),
                            StatsWidget(statsName: "Learning Curve", statsMax: 200, color: Colors.green),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StatsWidget(statsName: "MP", statsMax: 200, color: Colors.blue),
                            VSpacing(),
                            StatsWidget(statsName: "Quality", statsMax: 200, color: Colors.yellow),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            )),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: NesContainer(
            label: "This is Me!",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RiveAnimation.asset(
                    onInit: _onRiveInit,
                    'assets/pixel_adds08_move.riv',
                    placeHolder: const Placeholder(),
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                          child: const Text("left"),
                          onPressed: () {
                            setState(() {
                              isMoveRight = false;
                              _hitBump();
                            });
                          }),
                      MaterialButton(
                          child: const Text("Stop"),
                          onPressed: () {
                            setState(() {
                              isMoveRight = null;
                              _hitBump();
                            });
                          }),
                      MaterialButton(
                          child: const Text("Right"),
                          onPressed: () {
                            setState(() {
                              isMoveRight = true;
                              _hitBump();
                            });
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
