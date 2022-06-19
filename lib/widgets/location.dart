import 'package:flutter/material.dart';
//import 'package:map_view/map_view.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/location_data.dart';
// import '../helpers/ensure_visible.dart';

// import 'package:flutter_map/flutter_map.dart';
// import 'package:geocoder/geocoder.dart';
import 'package:latlong/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   static const _initialCameraPosition = CameraPosition(
//     target: LatLng(37.773972, -122.431297),
//     zoom: 11.5,
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//         initialCameraPosition: _initialCameraPosition,
//       ),
//     );
//   }
// }
class LocationInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  double long = 49.5;
  double lat = -0.09;
  LatLng point = LatLng(49.5, -0.09);
  //var location = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FlutterMap(
        //   options: MapOptions(
        //     onTap: (p) async {
        //       location = await Geocoder.local.findAddressesFromCoordinates(
        //           new Coordinates(p.latitude, p.longitude));

        //       setState(() {
        //         point = p;
        //         print(p);
        //       });

        //       print(
        //           "${location.first.countryName} - ${location.first.featureName}");
        //     },
        //     center: LatLng(49.5, -0.09),
        //     zoom: 5.0,
        //   ),
        //   layers: [
        //     TileLayerOptions(
        //         urlTemplate:
        //             "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        //         subdomains: ['a', 'b', 'c']),
        //     MarkerLayerOptions(
        //       markers: [
        //         Marker(
        //           width: 80.0,
        //           height: 80.0,
        //           point: point,
        //           builder: (ctx) => Container(
        //             child: Icon(
        //               Icons.location_on,
        //               color: Colors.red,
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //   ],
        // ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: "Search for your localisation",
                    prefixIcon: Icon(Icons.location_on_outlined),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("kk"
                          // "${location.first.countryName},${location.first.locality}, ${location.first.featureName}"
                          ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//   // mapOptions({Future<Null> Function(p) onTap, LatLng center, double zoom}) {}
// }

// //   final FocusNode _addressInputFocusNode = FocusNode();
// //   Uri _staticMapUri;
// //   final TextEditingController _addressInputController = TextEditingController();

// //   LocationData _locationData;

// //   @override
// //   void initState() {
// //     _addressInputFocusNode.addListener(_updateLocation);
// //     //getStaticMap();
// //     super.initState();
// //   }

// //   @override
// //   void dispose() {
// //     _addressInputFocusNode.removeListener(_updateLocation);
// //     super.dispose();
// //   }

// //   void getStaticMap(String address) async {
// //     if (address.isEmpty) {
// //       _staticMapUri = null;
// //       return;
// //     }

// //     final Uri uri = Uri.https(
// //       'maps.googleapis.com',
// //       '/maps/api/geocode/json',
// //       {'address': address, 'key': 'AIzaSyDVp2LbR5y6iHgTdjB7-zxWeqJYLefnwys'},
// //     );
// //     final http.Response response = await http.get(uri);

// //     final decodedResponse = json.decode(response.body);
// //     final formattedAddress = decodedResponse['results'][0]['formatted_address'];
// //     final coords = decodedResponse['results'][0]['geometry']['location'];

// //     _locationData =
// //         LocationData(coords['lat'], coords['lng'], formattedAddress);

// //     final StaticMapProvider staticMapviewProvider =
// //         StaticMapProvider('AIzaSyDVp2LbR5y6iHgTdjB7-zxWeqJYLefnwys');

// //     _staticMapUri = staticMapviewProvider.getStaticUriWithMarkers([
// //       Marker('positon', 'position', _locationData.latitude,
// //           _locationData.longitude)
// //     ],
// //         center: Location(_locationData.latitude, _locationData.longitude),
// //         width: 500,
// //         height: 300,
// //         maptype: StaticMapViewType.roadmap);
// //     setState(() {
// //       _addressInputController.text = _locationData.address;
// //       _staticMapUri = _staticMapUri;
// //     });
// //   }

// //   void _updateLocation() {
// //     if (!_addressInputFocusNode.hasFocus) {
// //       getStaticMap(_addressInputController.text);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: <Widget>[
// //         //  EnsureVisibleWhenFocused()
// //         // focusNode: _addressInputFocusNode,
// //         TextFormField(
// //           focusNode: _addressInputFocusNode,
// //           controller: _addressInputController,
// //           validator: (String value) {
// //             if (_locationData == null || value.isEmpty) {
// //               return 'No Valid Location found';
// //             }
// //           },
// //           decoration: InputDecoration(labelText: 'Address'),
// //         ),
// //         SizedBox(height: 10.0),
// //         Image.network(_staticMapUri.toString())
// //       ],
// //     );
// //   }
// // }
}
