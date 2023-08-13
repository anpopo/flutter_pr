import 'package:first_web/favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class TestMapScreen extends StatelessWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const TestMapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(isSelecting == true ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (isSelecting == true)
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.save),
            )
        ],
      ),
      body: const Placeholder(),
    );
  }
}
