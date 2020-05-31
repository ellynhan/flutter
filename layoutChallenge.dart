import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Colors.red,
                width:100,
              ),
              Container(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Container(
                     color:Colors.yellow,
                     width:100,
                     height:100,
                   ),
                   Container(
                     color:Colors.green,
                     width:100,
                     height:100,
                   ),
                 ],
                )
              ),
              Container(
                color: Colors.blue,
                width:100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

