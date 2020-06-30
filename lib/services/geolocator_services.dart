import 'package:geolocator/geolocator.dart';

class GeolocatorServices{

  final geolocator = Geolocator();

  Future<Position> getLocation() async{
    Position position = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, locationPermissionLevel: GeolocationPermission.location);
    print(position.longitude);
    return position;
  }

  Future<double> getDistance(double startLatitude,double startLongitude,double endLatitude,double endLongitude) async {
    return await geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }
}