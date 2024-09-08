import 'package:flutter_animate/flutter_animate.dart';

enum AppEnvironment { dev, testing, production }

const AppEnvironment appEnvironment = AppEnvironment.dev;
const double verticalPadding = 12;
final Duration textTypingAnimationDuration = (appEnvironment == AppEnvironment.dev) ? 10.ms : 50.ms;
