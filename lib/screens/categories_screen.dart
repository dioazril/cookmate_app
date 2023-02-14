import 'package:flutter/material.dart';
import '../data/meals_data.dart';
import '../data/category_items_view.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: categoriesData
              .map((data) => CategoryItem(
                    id: data.id,
                    title: data.title,
                    color: data.color,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
