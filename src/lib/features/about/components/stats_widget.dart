import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nes_ui/nes_ui.dart';

class StatsWidget extends StatelessWidget {
  final String statsName;
  final double statsMax;
  final Color color;

  const StatsWidget({
    super.key,
    required this.statsName,
    required this.statsMax,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(statsName),
        Animate().custom(
          duration: 2000.milliseconds,
          begin: 10,
          end: statsMax,
          builder: (_, value, __) => Row(
            children: [
              NesContainer(
                backgroundColor: color,
                height: 32,
                width: value,
              ),
              const SizedBox(
                width: 6,
              ),
              Text("${(value / 2).ceil().toString()}%")
            ],
          ),
        ),
      ],
    );
  }
}
