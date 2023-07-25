import 'package:first_web/meal_road/models/meal.dart';
import 'package:first_web/meal_road/screens/meal_details.dart';
import 'package:first_web/meal_road/widgets/meal_item.dart';
import 'package:flutter/material.dart';

class MealsScreen extends StatelessWidget {
  final String title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
    required this.onToggleFavorite,
  });

  void _selectMealDetail(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetails(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: meals.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Uh oh ... Noting here!',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    'Try selecting a different category!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) => Stack(
                children: [
                  MealItem(
                    meal: meals[index],
                    onMealSelect: (meal) {
                      _selectMealDetail(context, meal);
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      onToggleFavorite(meals[index]);
                    },
                    icon: const Icon(Icons.star_border),
                  ),
                ],
              ),
            ),
    );
  }
}
