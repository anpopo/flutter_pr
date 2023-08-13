import 'package:first_web/favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const defaultLat = 37.422;
const defaultLng = -122.084;

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      latitude: defaultLat,
      longitude: defaultLng,
      address: '',
    ),
    this.isSelecting = true,
  });

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  LatLng _pickedPosition = const LatLng(defaultLat, defaultLng);

  @override
  void initState() {
    _pickedPosition =
        LatLng(widget.location.latitude, widget.location.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isSelecting ? 'Pick Your Location' : 'Your Location'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedPosition);
              },
              icon: const Icon(Icons.save),
            )
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting == false
            ? null
            : (position) {
                final latitude = position.latitude;
                final longitude = position.longitude;

                setState(() {
                  _pickedPosition = LatLng(latitude, longitude);
                });
              },
        initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
            zoom: 16),
        markers: widget.isSelecting
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedPosition,
                ),
              },
      ),
    );
  }
}
