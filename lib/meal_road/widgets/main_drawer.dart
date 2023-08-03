import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  final void Function(String identifier) onSelectScreen;

  const MainDrawer({
    super.key,
    required this.onSelectScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            child: Row(
              children: [
                Icon(
                  Icons.fastfood_outlined,
                  size: 36,
                ),
                SizedBox(width: 14),
                Text(
                  'Cooking Up',
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.restaurant,
              size: 26,
            ),
            title: const Text('Meals!'),
            onTap: () {
              onSelectScreen('meals');
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 26,
            ),
            title: const Text('Filters'),
            onTap: () {
              onSelectScreen('filters');
            },
          ),
        ],
      ),
    );
  }
}
