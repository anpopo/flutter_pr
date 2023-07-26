// import 'package:first_web/meal_road/screens/tabs_screen.dart';
import 'package:first_web/meal_road/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  final Map<Filter, bool> selectedFilter;
  const FiltersScreen({super.key, required this.selectedFilter});

  @override
  State<StatefulWidget> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.selectedFilter[Filter.glutenFree]!;
    _isLactoseFree = widget.selectedFilter[Filter.lactoseFree]!;
    _isVegetarian = widget.selectedFilter[Filter.vegetarian]!;
    _isVegan = widget.selectedFilter[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
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
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFree,
            Filter.lactoseFree: _isLactoseFree,
            Filter.vegetarian: _isVegetarian,
            Filter.vegan: _isVegan,
          });

          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              title: const Text('Gluten-free'),
              value: _isGlutenFree,
              subtitle: const Text('Only include gluten-free meals.'),
              contentPadding: const EdgeInsets.only(left: 24, right: 20),
              onChanged: (selected) {
                setState(() {
                  _isGlutenFree = selected;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Lactose-free'),
              value: _isLactoseFree,
              subtitle: const Text('Only include lactose-free meals.'),
              contentPadding: const EdgeInsets.only(left: 24, right: 20),
              onChanged: (selected) {
                setState(() {
                  _isLactoseFree = selected;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Vegetarian'),
              value: _isVegetarian,
              subtitle: const Text('Only include vegetarian meals.'),
              contentPadding: const EdgeInsets.only(left: 24, right: 20),
              onChanged: (selected) {
                setState(() {
                  _isVegetarian = selected;
                });
              },
            ),
            SwitchListTile(
              title: const Text('Vegan'),
              value: _isVegan,
              subtitle: const Text('Only include vegan meals.'),
              contentPadding: const EdgeInsets.only(left: 24, right: 20),
              onChanged: (selected) {
                setState(() {
                  _isVegan = selected;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
