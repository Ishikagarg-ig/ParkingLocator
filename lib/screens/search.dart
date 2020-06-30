import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkingapp/models/place.dart';
import 'package:parkingapp/services/geolocator_services.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final getGeo = GeolocatorServices();

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
          builder: (_, places, __) {
            return (places != null) ? Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: LatLng(currentPosition.latitude,
                           currentPosition.longitude),
                        zoom: 16.0),
                    zoomGesturesEnabled: true,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        return FutureProvider(
                          create: (context)=> getGeo.getDistance(currentPosition.latitude, currentPosition.longitude, places[index].geometry.location.lat, places[index].geometry.location.lng),
                          child: Card(
                            child: ListTile(
                              title: Text(places[index].name),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  (places[index].rating!=null) ? Row(
                                    children: <Widget>[
                                      RatingBarIndicator(
                                        rating: places[index].rating,
                                        itemBuilder: (context,index) => Icon(Icons.star, color: Colors.amber,),
                                        itemCount: 5,
                                        itemSize: 10.0,
                                        direction: Axis.horizontal,
                                      ),
                                    ],
                                  ) : Row(),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Consumer<double>(
                                    builder: (context,meters,widget){
                                      return (meters!=null)
                                      ? Text('${places[index].vicinity} \u00b7 ${(meters/1609).round()} mi'),
                                    },
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.directions),
                                color: Theme.of(context).primaryColor,
                                onPressed: (){},
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ): Center(child: CircularProgressIndicator());
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}