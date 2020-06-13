import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title:Text('KK'),
          backgroundColor: Colors.amber,
        ),
        body: MapSample(),
      )
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition pnuFrontGate = CameraPosition(
    target: LatLng(35.231609, 129.084196),
    zoom: 14.4746,
  );

  static final CameraPosition pnuSwCenter = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(35.235985, 129.077029),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: pnuFrontGate,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToThePlace,
        label: Text('과학기술연구동이 어디냐면'),
        icon: Icon(Icons.domain),
      ),
    );
  }

  Future<void> _goToThePlace() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(pnuSwCenter));
  }
}
