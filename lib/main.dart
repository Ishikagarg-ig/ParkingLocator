import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parkingapp/models/place.dart';
import 'package:parkingapp/screens/search.dart';
import 'package:parkingapp/services/geolocator_services.dart';
import 'package:parkingapp/services/places_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final locationService = GeolocatorServices();
  final placesService =PlacesService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locationService.getLocation(),),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context,position,places){
            return (position!=null) ? placesService.getPlaces(position.latitude,position.longitude): null;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Search(),
      ),
    );
  }
}