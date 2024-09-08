import 'package:flutter/material.dart';
import 'package:src/consts.dart';

class VSpacing extends StatelessWidget {
  const VSpacing({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: verticalPadding,
    );
  }
}
