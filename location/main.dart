import 'package:flutter/material.dart';
import 'package:maptest/services/location_service.dart';
import 'package:maptest/view/homeview.dart';
import 'package:provider/provider.dart';
import 'package:maptest/datamodels/user_location.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserLocation>.value(
        initialData: UserLocation(),
        value: LocationService().locationStream,
        child: MaterialApp(title: 'Flutter Demo', home: HomeView()));
  }
}
