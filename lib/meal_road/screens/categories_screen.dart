import 'package:first_web/meal_road/data/dummy_data.dart';
import 'package:first_web/meal_road/models/category.dart';
import 'package:first_web/meal_road/models/meal.dart';
import 'package:first_web/meal_road/screens/filters_screen.dart';
import 'package:first_web/meal_road/screens/meals_screen.dart';
import 'package:first_web/meal_road/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final void Function(Meal meal) onToggleFavorite;
  final Map<Filter, bool> filters;

  const CategoryScreen({
    super.key,
    required this.onToggleFavorite,
    required this.filters,
  });

  void _selectCategory(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: dummyMeals
              .where((meal) {
                if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
                  return false;
                }

                if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
                  return false;
                }

                if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
                  return false;
                }

                if (filters[Filter.vegan]! && !meal.isVegan) {
                  return false;
                }

                return true;
              })
              .where((meal) => meal.categories.contains(category.id))
              .toList(),
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const category = availableCategories;

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: category.length,
      itemBuilder: (context, index) {
        final selectedCategory = category[index];
        return CategoryGridItem(
          category: selectedCategory,
          onSelectCategory: () {
            _selectCategory(context, selectedCategory);
          },
        );
      },
    );
  }
}
