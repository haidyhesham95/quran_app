import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_quran/Widget/app_bar_widget.dart';
import 'package:my_quran/Widget/custom_container.dart';


class QuranDetailsScreen extends StatefulWidget {
  QuranDetailsScreen({
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
    var quran = ModalRoute.of(context)?.settings.arguments as QuranModel;
    if (quranDetails.isEmpty) {
      loadSura(quran.index);
    }
    return Stack(
      children: [
        Image.asset('assets/images/Untitled design.png',height: double.infinity,width: double.infinity,fit: BoxFit.fill,opacity:AlwaysStoppedAnimation(0.9),),
        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: appbarWidget(context,  " سورة ${quran.name} ",backgroundColor: Colors.transparent),

          body:customContainer(context,
            quranDetails.length,
              quranDetails
            ),
          ),

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
  QuranModel(this. index,this.name
      );
}
