import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingapp/models/geometry.dart';

class Place{
  final String name;
  final double rating;
  final int userRatingCount;
  final String vicinity;
  final Geometry geometry;
  final BitmapDescriptor icon;

  Place({this.geometry,this.name,this.rating,this.userRatingCount,this.vicinity,this.icon});

  Place.fromJson(Map<dynamic, dynamic> parsedJson, BitmapDescriptor icon)
  : name = parsedJson['name'],
  rating = (parsedJson['rating']!=null) ? parsedJson['rating'].toDouble() : null,
  userRatingCount = (parsedJson['userRatingCount']!=null) ? parsedJson['userRatingCount'] : null,
  vicinity = parsedJson['vicinity'],
  geometry = parsedJson['geometry'],
  icon = icon;
}