import 'dart:convert';

import 'package:first_web/shopping_list/data/categories.dart';
import 'package:first_web/shopping_list/models/grocery_item.dart';
import 'package:first_web/shopping_list/screens/new_item.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;
  String? _errorMessage;

  void _loadItems() async {
    final url = Uri.https(
        '',
        'items.json');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        setState(() {
          _errorMessage = 'Fail to fetch data. Please try again later.';
          _isLoading = false;
        });
      } else if (response.body.isNotEmpty && response.body != 'null') {
        final Map<String, dynamic> itemList = jsonDecode(response.body);
        final List<GroceryItem> temporaryGroceryItem = [];

        for (final item in itemList.entries) {
          final (name, quantity, category) = switch (item.value) {
            {
            'category': String category,
            'name': String name,
            'quantity': int quantity
            } =>
            (
            name,
            quantity,
            categories.values.firstWhere((cat) => cat.title == category)
            ),
            _ => throw const FormatException('Invalid Format!')
          };

          temporaryGroceryItem.add(
            GroceryItem(
              id: item.key,
              category: category,
              name: name,
              quantity: quantity,
            ),
          );
        }

        setState(() {
          _groceryItems = temporaryGroceryItem;
          _isLoading = false;
        });
      }
    } catch (err) {
      setState(() {
        _errorMessage = 'Something went wrong.. Please try again later.';
        _isLoading = false;
      });
    }
  }

  void _addItem() async {
    ScaffoldMessenger.of(context).clearSnackBars();
    final groceryItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (groceryItem != null) {
      setState(() {
        _groceryItems.add(groceryItem);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  @override
  Widget build(BuildContext context) {
    if (_groceryItems.isEmpty) {
      _loadItems();
    }

    Widget content;

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (_groceryItems.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'No Item added yet!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('try to'),
                TextButton(
                  onPressed: _addItem,
                  child: const Text(
                    'add item',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, idx) {
          return Dismissible(
            key: ValueKey(_groceryItems[idx].id),
            onDismissed: (direction) async {
              final groceryItem = _groceryItems[idx];
              final url = Uri.https(
                  '',
                  'items/${groceryItem.id}.json');

              final response = await http.delete(url);

              if (response.statusCode == 200 && mounted) {
                setState(() {
                  _groceryItems.remove(groceryItem);
                });

                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('Item removed!'),
                  ),
                );
              }
            },
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red.withOpacity(0.8),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
                size: 40,
              ),
            ),
            child: ListTile(
              title: Text(_groceryItems[idx].name),
              leading: Container(
                width: 24,
                height: 24,
                color: _groceryItems[idx].category.color,
              ),
              trailing: Text(_groceryItems[idx].quantity.toString()),
            ),
          );
        },
      );
    }

    if (_errorMessage != null) {
      content = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorMessage = null;
                  });
                },
                child: const Text('retry')),
          ],
        ),
      );
    }

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
      body: content,
    );
  }
}
