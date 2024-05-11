import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quran/Widget/app_bar_widget.dart';
import 'package:my_quran/Widget/custom_container.dart';

import '../../Const/Styels.dart';

class HadythDetails extends StatefulWidget {
   HadythDetails({super.key});

static const String routeName = 'HadythDetails';


  @override
  State<HadythDetails> createState() => _HadythDetailsState();
}

class _HadythDetailsState extends State<HadythDetails> {
  List<String> ahadythDetails = [];

  @override
  Widget build(BuildContext context) {
    var hadyth = ModalRoute.of(context)?.settings.arguments as HadythModel;
    if (ahadythDetails.isEmpty) {
      loadHadyth(hadyth.index);
    }

    return Stack(
      children: [
        Image.asset('assets/images/Untitled design.png',height: double.infinity,width: double.infinity,fit: BoxFit.fill,opacity:AlwaysStoppedAnimation(0.9),),
        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: appbarWidget(context, "  ${hadyth.name} ",backgroundColor: Colors.transparent),

          body:customContainer(context,
              ahadythDetails.length,
               ahadythDetails,
            style: Styles.textStyle22,

            ),
          ),

      ],
    );
  }

  void loadHadyth(int index) async {
    String contant =
    await rootBundle.loadString('assets/hadeth/h${index + 1}.txt');

    ahadythDetails.addAll(contant.split("\n"));
    setState(() {});
  }
}



class HadythModel {
  int index;
  String name;
  HadythModel(this. index,this.name
      );
}
