import 'package:first_web/favorite_places/models/place.dart';
import 'package:first_web/favorite_places/screens/place_detail_screen.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  final List<Place> places;

  const PlacesList({super.key, required this.places});

  @override
  Widget build(BuildContext context) {
    return places.isEmpty
        ? Center(
            child: Text(
              'No places added yet.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 26,
                      backgroundImage: FileImage(places[index].image),
                    ),
                    title: Text(
                      places[index].title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) =>
                              PlaceDetailScreen(place: places[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
  }
}
