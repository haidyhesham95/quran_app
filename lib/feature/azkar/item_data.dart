import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Const/colors.dart';
import '../../const/widgets/app_bar_widget.dart';

class ItemData extends StatelessWidget {
  const ItemData({super.key, required this.appText, required this.itemCount, required this.textData});
  final String appText;
  final  int itemCount;
  final List textData;



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Image.asset('assets/images/Untitled design.png',height: double.infinity,width: double.infinity,fit: BoxFit.fill,opacity:AlwaysStoppedAnimation(0.9),),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appbarWidget(context, appText,backgroundColor: Colors.transparent),

          body: Center(
            child: Container(
              height: size.height*0.85,
              width: size.width* 0.9,
              decoration: BoxDecoration(
                  color: kGreen.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: ListView.separated(
                separatorBuilder: (context, index) =>Divider(thickness: 1,color: kGreen,),
                itemCount: itemCount,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(textData[index]['content'],style: GoogleFonts.amiriQuran(color:Colors.blueGrey.shade800,fontSize: 22,fontWeight: FontWeight.bold),),
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
