import 'package:first_web/shopping_list/data/dummy_items.dart';
import 'package:first_web/shopping_list/screens/new_item.dart';
import 'package:flutter/material.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final groceryList = groceryItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: (ctx, idx) {
          return ListTile(
            title: Text(groceryList[idx].name),
            leading: Container(
              width: 24,
              height: 24,
              color: groceryList[idx].category.color,
            ),
            trailing: Text(groceryList[idx].quantity.toString()),
          );
        },
      ),
    );
  }
}
