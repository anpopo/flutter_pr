import 'package:first_web/meal_road/models/meal.dart';
import 'package:first_web/meal_road/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filtersProvider =
StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
      (ref) => FiltersNotifier(),
);

final filteredMealsProvider = Provider<List<Meal>>((ref) {
  final meals = ref.watch(mealsProvider);
  final filtersState = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (filtersState[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (filtersState[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (filtersState[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    if (filtersState[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  });

  void setFilters(Map<Filter, bool> filtersState) {
    state = filtersState;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}
