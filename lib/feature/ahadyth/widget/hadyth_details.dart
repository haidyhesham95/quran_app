import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Const/styels.dart';
import '../../../const/widgets/app_bar_widget.dart';
import '../../../const/widgets/custom_container.dart';

class HadythDetails extends StatefulWidget {
  const HadythDetails({super.key});

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
        Image.asset(
          'assets/images/Untitled design.png',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.fill,
          opacity: const AlwaysStoppedAnimation(0.9),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appbarWidget(context, "  ${hadyth.name} ",
              backgroundColor: Colors.transparent),
          body: customContainer(
            context,
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
  HadythModel(this.index, this.name);
}
