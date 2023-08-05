// import 'package:first_web/meal_road/screens/tabs_screen.dart';
import 'package:first_web/meal_road/providers/filters_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filtersState = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      //         return const TabsScreen();
      //       }));
      //     }
      //   },
      // ),
      body:
          // WillPopScope(
          //   onWillPop: () async {
          //     ref.read(filtersProvider.notifier).setFilters({
          //       Filter.glutenFree: _isGlutenFree,
          //       Filter.lactoseFree: _isLactoseFree,
          //       Filter.vegetarian: _isVegetarian,
          //       Filter.vegan: _isVegan,
          //     });
          //     return true; // true > pop
          //   },
          //   child:
          Column(
        children: [
          SwitchListTile(
            title: const Text('Gluten-free'),
            value: filtersState[Filter.glutenFree]!,
            subtitle: const Text('Only include gluten-free meals.'),
            contentPadding: const EdgeInsets.only(left: 24, right: 20),
            onChanged: (selected) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, selected);
            },
          ),
          SwitchListTile(
            title: const Text('Lactose-free'),
            value: filtersState[Filter.lactoseFree]!,
            subtitle: const Text('Only include lactose-free meals.'),
            contentPadding: const EdgeInsets.only(left: 24, right: 20),
            onChanged: (selected) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, selected);
            },
          ),
          SwitchListTile(
            title: const Text('Vegetarian'),
            value: filtersState[Filter.vegetarian]!,
            subtitle: const Text('Only include vegetarian meals.'),
            contentPadding: const EdgeInsets.only(left: 24, right: 20),
            onChanged: (selected) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, selected);
            },
          ),
          SwitchListTile(
            title: const Text('Vegan'),
            value: filtersState[Filter.vegan]!,
            subtitle: const Text('Only include vegan meals.'),
            contentPadding: const EdgeInsets.only(left: 24, right: 20),
            onChanged: (selected) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, selected);
            },
          ),
        ],
      ),
      // ),
    );
  }
}
