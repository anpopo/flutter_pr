import 'package:first_web/meal_road/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
        (ref) => FavoriteMealsNotifier());

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    // 항상 불변된 객체 상태로 state 를 관리해야 한다 -> 그렇기 때문에 새로운 list 를 생성하여 할당한다.
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  bool isContains(Meal meal) => state.contains(meal);
}
