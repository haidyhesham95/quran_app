import 'package:flutter/material.dart';
import 'package:my_quran/feature/azkar/widget/item_data.dart';


import '../../../const/widgets/app_bar_widget.dart';
import '../../../generated/assets.dart';
import '../widget/build_item.dart';


class AzkarView extends StatelessWidget {
  final BuildContext context;
  final List<CategoryItem> categories;

  AzkarView({
    super.key,
    required this.context,
  }) : categories = [
          CategoryItem(
            text: "أذكار الصباح",
            image: Assets.images1,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ItemData(name: 'أذكار الصباح')));
            },
          ),
          CategoryItem(
            text: " أذكار الاستيقاظ",
            image: Assets.images2,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ItemData(name: 'أذكار الاستيقاظ')));
            },
          ),
          CategoryItem(
            text: "أذكار النوم",
            image: Assets.imagesMoon,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ItemData(name: 'أذكار النوم')));
            },
          ),
          CategoryItem(
            text: " أذكار المساء",
            image: Assets.imagesEvening,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ItemData(name: 'أذكار المساء')));
            },
          ),
          CategoryItem(
            text: "أدعية الأنبياء",
            image: Assets.images5,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ItemData(name: 'أدعية الأنبياء')));
            },
          ),
          CategoryItem(
            text: "أدعية قرآنية",
            image: Assets.images3,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ItemData(name: 'أدعية قرآنية')));
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
