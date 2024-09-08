import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';
import 'package:src/features/about/models/about_me_model.dart';
import 'package:src/features/about/widgets/academic.dart';
import 'package:src/features/about/widgets/other.dart';
import 'package:src/features/about/widgets/profile.dart';

class AboutMePage extends StatefulWidget {
  const AboutMePage({super.key});

  @override
  State<AboutMePage> createState() => _AboutMePageState();
}

class _AboutMePageState extends State<AboutMePage> {
  final List<ListOfAboutMeModel> listOfAboutMe = [
    ListOfAboutMeModel("Personal Profile", const ProfileWidget()),
    ListOfAboutMeModel("Academic Profile", const AcademicWidget()),
    ListOfAboutMeModel("Career Profile", const OtherWidget()),
    ListOfAboutMeModel("More ...", const OtherWidget()),
  ];

  int selectedWidgetIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
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
