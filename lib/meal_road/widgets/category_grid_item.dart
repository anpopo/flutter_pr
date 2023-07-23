import 'package:first_web/meal_road/models/category.dart';
import 'package:flutter/material.dart';

class CategoryGridItem extends StatelessWidget {
  final Category category;

  const CategoryGridItem({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    // give options to setting a lot of thins related with styling
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary.withOpacity(0.3),
          category.color.withOpacity(0.65),
          category.color.withOpacity(0.90),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )),
      child: Text(
        category.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
  }
}
