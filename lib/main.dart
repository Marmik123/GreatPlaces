import 'package:flutter/material.dart';
import 'package:greatplaces/provider/great_places.dart';
import 'package:greatplaces/screens/add_places_screen.dart';
import 'package:greatplaces/screens/places_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: Colors.amber,
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: PlacesListScreen(),
        routes: {AddPlaceScreen.routName: (context) => AddPlaceScreen()},
      ),
    );
  }
}
