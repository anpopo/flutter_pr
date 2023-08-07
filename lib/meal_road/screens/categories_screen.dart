import 'package:first_web/meal_road/data/dummy_data.dart';
import 'package:first_web/meal_road/models/category.dart';
import 'package:first_web/meal_road/models/meal.dart';
import 'package:first_web/meal_road/screens/meals_screen.dart';
import 'package:first_web/meal_road/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final List<Meal> availableMeals;

  const CategoryScreen({
    super.key,
    required this.availableMeals,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: widget.availableMeals
              .where((meal) => meal.categories.contains(category.id))
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const category = availableCategories;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (ctx, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0.0),
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: child,
        );
      },
      child: GridView.builder(
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
      ),
    );
  }
}
