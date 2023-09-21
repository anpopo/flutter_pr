import 'package:flutter/material.dart';

void main() {
  runApp(const KeyTestApp());
}

class KeyTestApp extends StatelessWidget {
  const KeyTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('key test app'),
        ),
        body: const ItemList(),
      ),
    );
  }
}

class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  int count = 0;
  final List<String> _items = [];

  void _onRemove(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                _items.add('value ${count++}');
              });
            },
            icon: const Icon(Icons.add),
            label: const Text('add'),
          ),
        ),
        Expanded(
          child: ListView(
            children: _items
                .map((e) => Item(
                      key: ValueKey(e),
                      index: _items.indexOf(e),
                      onRemove: _onRemove,
                      value: e,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class Item extends StatefulWidget {
  const Item({
    super.key,
    required this.index,
    required this.onRemove,
    required this.value,
  });

  final int index;
  final void Function(int) onRemove;
  final String value;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  late bool _isChecked;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _isChecked = false;
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant Item oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isChecked = _isChecked;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: _isChecked,
      onChanged: (value) {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      title: TextFormField(
        controller: _controller,
        maxLines: 1,
      ),
      secondary: IconButton(
        onPressed: () {
          widget.onRemove(widget.index);
        },
        icon: const Icon(Icons.close),
      ),
    );
  }
}
