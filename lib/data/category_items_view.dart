import 'package:flutter/material.dart';

import '../screens/category_items_screen.dart';

class CategoryItem extends StatefulWidget {
  final String id;
  final String title;
  final Color color;
  const CategoryItem(
      {Key? key, required this.title, required this.color, required this.id})
      : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  void selectCategory(BuildContext context) {
    // Use navigator.pushNamed
    Navigator.of(context).pushNamed(CategoryItemsScreen.routeName, arguments: {
      'id': widget.id,
      'title': widget.title,
      'color': widget.color,
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectCategory(context);
      },
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              widget.color.withOpacity(0.7),
              widget.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
