import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/models/places.dart';

class MapsScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  bool isSelecting;

  MapsScreen(
      {this.initialLocation =
          const PlaceLocation(latitude: 21.1855485, longitude: 72.7831793),
      this.isSelecting = false});
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng pickedLocation;

  void selectLocation(LatLng position) {
    setState(() {
      widget.isSelecting = true;
      pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Map"),
        actions: <Widget>[
          if (widget.isSelecting)
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                Navigator.of(context).pop(pickedLocation);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.initialLocation.latitude,
              widget.initialLocation.longitude),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? null : selectLocation,
        markers: pickedLocation == null
            ? null
            : {
                Marker(
                  markerId: MarkerId('m1'),
                  position: pickedLocation,
                )
              },
      ),
    );
  }
}
