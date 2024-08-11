import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Const/styels.dart';
import '../../../const/widgets/app_bar_widget.dart';
import '../../../generated/assets.dart';

class QuranDetailsScreen extends StatefulWidget {
  const QuranDetailsScreen({
    super.key,
  });
  static const String routeName = 'quranDetailsScreen';

  @override
  State<QuranDetailsScreen> createState() => _QuranDetailsScreenState();
}

class _QuranDetailsScreenState extends State<QuranDetailsScreen> {
  List<String> quranDetails = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var quran = ModalRoute.of(context)?.settings.arguments as QuranModel;
    if (quranDetails.isEmpty) {
      loadSura(quran.index);
    }
    return Stack(
      children: [
        Positioned.fill(
          child: SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(Assets.imagesCover1,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  opacity: const AlwaysStoppedAnimation(0.8))),
        ),
        Scaffold(
            backgroundColor: Colors.transparent,
            appBar: appbarWidget(context, " سورة ${quran.name} ",
                backgroundColor: Colors.transparent),
            body: Center(
                child: ListView.builder(
              itemCount: quranDetails.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Center(
                        child: Text(
                      quranDetails[index],
                      style: Styles.textStyleName22,
                    )),
                  ),
                );
              },
            ))),
      ],
    );
  }

  void loadSura(int index) async {
    String file =
        await rootBundle.loadString('assets/quran_files/${index + 1}.txt');
    //quranDetails.addAll(contant.split("\n"));
    List<String> suraLines = file.split("\n");

    for (int i = 0; i < suraLines.length; i++) {
      String line = suraLines[i];
      String modifiedLine = "${line.trimRight()} (${1 + i})";
      quranDetails.add(modifiedLine);
    }
    setState(() {});
  }
}

class QuranModel {
  int index;
  String name;
  QuranModel(this.index, this.name);
}
