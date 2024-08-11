import 'package:flutter/material.dart';

import 'package:my_quran/const/widgets/app_bar_widget.dart';
import 'package:my_quran/feature/azkar/ad3yia_a.dart';
import 'package:my_quran/feature/azkar/build_item.dart';
import '../../generated/assets.dart';
import 'Ad3yia_Q.dart';
import 'Azkar_Astikaz.dart';
import 'Azkar_Massa.dart';
import 'Azkar_Noom.dart';
import 'Azkar_Saba7.dart';

class Azkar extends StatelessWidget {
  final BuildContext context;
  final List<CategoryItem> categories;

  Azkar({
    super.key,
    required this.context,
  }) : categories = [
          CategoryItem(
            text: "أذكار الصباح",
            image: Assets.images1,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AzkarSaba7()));
            },
          ),
          CategoryItem(
            text: " أذكار الاستيقاظ",
            image: Assets.images2,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AzkarAstikaz()));
            },
          ),
          CategoryItem(
            text: "أذكار النوم",
            image: Assets.imagesMoon,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AzkarNoom()));
            },
          ),
          CategoryItem(
            text: " أذكار المساء",
            image: Assets.imagesEvening,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AzkarMassa()));
            },
          ),
          CategoryItem(
            text: "أدعية الأنبياء",
            image: Assets.images5,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Ad3yiaA()));
            },
          ),
          CategoryItem(
            text: "أدعية قرآنية",
            image: Assets.images3,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Ad3yiaQ()));
            },
          ),
        ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarWidget(
        context,
        'أذكار المسلم',
      ),
      body: Center(
        child: GridView.builder(
          padding: const EdgeInsets.only(right: 10, left: 10, bottom: 70),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
            mainAxisExtent: 135,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return buildItem(categories[index], context);
          },
        ),
      ),
    );
  }
}

class CategoryItem {
  final String text;
  final String image;
  final void Function()? onTap;

  CategoryItem({
    required this.text,
    required this.image,
    required this.onTap,
  });
}
