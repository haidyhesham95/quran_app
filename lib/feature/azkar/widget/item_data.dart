import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Const/colors.dart';
import '../../../const/widgets/app_bar_widget.dart';
import '../data/Map.dart';

class ItemData extends StatelessWidget {
  const ItemData(
      {super.key,
      required this.name,
      });
  final String name;


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<dynamic>contentData=azkar[0][name];


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
          appBar: appbarWidget(context, name,
              backgroundColor: Colors.transparent),
          body: Center(
            child: Container(
              height: size.height * 0.85,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  color: kGreen.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: kGreen,
                ),
                itemCount: contentData.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            contentData[index]['content'],
                            style: GoogleFonts.amiriQuran(
                                color: Colors.blueGrey.shade800,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
