import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/helpers/location_helper.dart';
import 'package:greatplaces/screens/maps_Screen.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapUrl = LocationHelper.staticMapImageUrl(
        latitude: locData.latitude, longitude: locData.longitude);
    print("eeeeee" + staticMapUrl);
    setState(() {
      _previewImageUrl = staticMapUrl;
    });
  }

  Future<void> selectOnMap() async {
    final LatLng selectedLocation = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MapsScreen()));

    if (selectedLocation == null) {
      return;
    }
    print(selectedLocation.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1)),
          height: 150,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Center(
                  child: Text(
                    "No Image chosen",
                  ),
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          children: [
            TextButton.icon(
              onPressed: getCurrentUserLocation,
              icon: Icon(Icons.location_on_outlined),
              label: Text('Current Location'),
              //  textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Select on Map'),
              textColor: Theme.of(context).primaryColor,
            )
          ],
        )
      ],
    );
  }
}
