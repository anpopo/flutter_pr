import 'package:first_web/meal_road/providers/favorites_provider.dart';
import 'package:first_web/meal_road/providers/meals_provider.dart';
import 'package:first_web/meal_road/screens/categories_screen.dart';
import 'package:first_web/meal_road/screens/filters_screen.dart';
import 'package:first_web/meal_road/screens/meals_screen.dart';
import 'package:first_web/meal_road/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  var _selectedPageIndex = 0;
  Map<Filter, bool> _selectedFilter = kInitialFilters;

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars();
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Marked as an not favorite!');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     _showInfoMessage('Marked as an favorite!');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) {
            return FiltersScreen(selectedFilter: _selectedFilter);
          },
        ),
      );

      setState(() {
        _selectedFilter = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPageIndex == 0 ? 'Categories' : 'Your Favorites'),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: _selectedPageIndex == 0
          ? CategoryScreen(
              availableMeals: ref.watch(mealsProvider).where((meal) {
                if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
                  return false;
                }

                if (_selectedFilter[Filter.lactoseFree]! &&
                    !meal.isLactoseFree) {
                  return false;
                }

                if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
                  return false;
                }

                if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
                  return false;
                }

                return true;
              }).toList(),
            )
          : MealsScreen(
              title: "Favorites",
              meals: ref.watch(favoriteMealsProvider),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
