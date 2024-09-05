import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:rive/rive.dart';
import 'package:typewritertext/typewritertext.dart';

enum AppEnvironment { dev, testing, production }

const AppEnvironment appEnvironment = AppEnvironment.dev;
const double verticalPadding = 12;
final Duration textTypingAnimationDuration = (appEnvironment == AppEnvironment.dev) ? 10.ms : 50.ms;

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    theme: flutterNesTheme(),
    home: const MainWidget(),
  ));
}

class VSpacing extends StatelessWidget {
  const VSpacing({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: verticalPadding,
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
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

class ListOfAboutMeModel {
  String title;
  Widget widget;
  ListOfAboutMeModel(this.title, this.widget);
}

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  final List<ListOfAboutMeModel> listOfAboutMe = [
    ListOfAboutMeModel("Personal Profile", const ProfileWidget()),
    ListOfAboutMeModel("Academic Profile", const OtherWidget()),
    ListOfAboutMeModel("Career Profile", const OtherWidget()),
    ListOfAboutMeModel("More ...", const OtherWidget()),
  ];

  int selectedWidgetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: NesContainer(
                label: "Topics about me",
                child: NesSelectionList(
                  initialIndex: selectedWidgetIndex,
                  children: listOfAboutMe.map((element) => Text(element.title)).toList(),
                  onSelect: (selected) {
                    setState(() {
                      selectedWidgetIndex = selected;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              flex: 3,
              child: NesContainer(
                label: listOfAboutMe[selectedWidgetIndex].title,
                child: listOfAboutMe[selectedWidgetIndex].widget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    print("hi");
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 2,
            child: Container(
              child: Text("Profile here"),
            )),
        Expanded(
          child: NesContainer(
            label: "This is Me!",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RiveAnimation.asset(
                    onInit: _onRiveInit,
                    'pixel_adds08_move.riv',
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

class OtherWidget extends StatelessWidget {
  const OtherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
