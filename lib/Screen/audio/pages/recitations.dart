import 'package:flutter/material.dart';

import 'package:my_quran/Const/Styels.dart';
import 'package:my_quran/Screen/audio/pages/quran_audio.dart';
import 'package:my_quran/Widget/app_bar_widget.dart';

import '../../../Const/colors.dart';
import '../../../Widget/list_item.dart';


import '../model/recitations.dart'; // Import your RecitationsModel and RecitationsApiService

class RecitationsPage extends StatefulWidget {
  @override
  _RecitationsPageState createState() => _RecitationsPageState();
}

class _RecitationsPageState extends State<RecitationsPage> {
  late Future<List<RecitationsModel>> _recitationsFuture;

  @override
  void initState() {
    super.initState();
    _recitationsFuture = RecitationsApiService.getRecitations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                  appBar:appbarWidget(context,'القراء',style: Styles.textStyleName23),
      body: FutureBuilder<List<RecitationsModel>>(
        future: _recitationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: kgray,),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Center(child: Text('حدث خطأ أثناء التحميل تأكَّد من اتصال الجهاز  بشبكة Wi-Fi ',style:Styles.text30 ,textAlign: TextAlign.center,)),
            );
          } else {
            final recitations = snapshot.data!;
            return
              Column(
                children:[
                  Expanded(
                    child: ListView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: recitations.length,
                    itemBuilder: (context, index) {
                      final recitation = recitations[index];
                      final nameToDisplay = recitation.translatedName ?? recitation.reciterName ?? '';
                      final styleToDisplay = RecitationsApiService.styleTranslations[recitation.style ?? 'مرتل'] ?? recitation.style ?? 'مرتل';



                      return ListItem(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReciterSurahsPage(reciterId: recitation.id.toString(),
                              appBarText: 'القارئ ${nameToDisplay} ',),
                            ),
                          );
                        },
                        data: nameToDisplay, // Display translated name if available, else display original reciter name
                        style: Styles.textStyleName20,
                        text: styleToDisplay, // Arabic style
                      );
                    },
                ),
                  ),
             ] );




          }
        },
      ),
    );
  }
}
